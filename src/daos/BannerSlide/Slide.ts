import { notFound } from "@shared/constants";
import { StatusCodes } from "http-status-codes";
import HttpError from "@helper/iHttpError";

import Banner, { BannerInstance } from "@src/models/Banner";
import Slide, { SlideAttributes, SlideInstance } from "@src/models/Slide";
import BannerDao from "./Banner";
import SlideLocationDao from "./SlideLocation";
import Media from "@src/models/Media";
import SlideLocation from "@src/models/SlideLocation";
import { Op } from "sequelize";
import { sequelize } from "@src/models";

const bannerDao = new BannerDao();
const locationDao = new SlideLocationDao();

class SlideDao {
  public async create(data: SlideAttributes): Promise<SlideInstance> {
    const location = await Slide.create({
      ...data,
    });
    return location;
  }

  public async edit(id: number, data: SlideAttributes): Promise<SlideInstance> {
    const location = await Slide.findByPk(id);
    console.log(id);
    if (!location) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    await location.update({ ...data });
    return location;
  }

  public async delete(id: number): Promise<void> {
    const location = await Slide.findByPk(id);
    if (location == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    await location.destroy();
  }

  public async find(id: number): Promise<SlideInstance> {
    const slide = await Slide.findByPk(id, {
      include: {
        model: Banner,
        as: "banners",
        through: { attributes: [] },
        include: [{ model: Media, as: "media" }],
      },
    });
    if (slide == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    return slide;
  }

  public async search(): Promise<SlideInstance[]> {
    return Slide.findAll({
      include: [
        {
          model: Banner,
          as: "banners",
          through: { attributes: [] },
          include: [{ model: Media, as: "media" }],
        },
        { model: SlideLocation, as: "location" },
      ],
    });
  }

  public async addBanner(id: number, bannerId: number): Promise<SlideInstance> {
    const banner = await bannerDao.find(bannerId);
    const slide = await this.find(id);
    if (slide == null || banner == null)
      throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    const result = await slide.addBanners(banner.id);
    return result;
  }

  public async removeBanner(
    id: number,
    bannerId: number
  ): Promise<SlideInstance> {
    const banner = await bannerDao.find(bannerId);
    const slide = await this.find(id);
    if (slide == null || banner == null)
      throw new HttpError(StatusCodes.NOT_FOUND, notFound);

    const result = await slide.removeBanner(banner.id);
    return result;
  }

  public async updateBanner(id: number, listNew: any[]): Promise<void> {
    return sequelize.transaction(async (t) => {
      const slide = await this.find(id);
      if (slide == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);

      const currentBanner: BannerInstance[] = await slide.getBanners({
        attributes: ["id"],
      });

      let listToRemove: number[] = [];
      let listToAdd: number[] = [];
      let listCurrent: number[] = currentBanner.map((item) => Number(item.id));

      listToRemove = listCurrent.filter((item) => listNew.indexOf(item) < 0);
      listToAdd = listNew.filter(
        (item) =>
          listToRemove.indexOf(item) < 0 && listCurrent.indexOf(item) < 0
      );

      console.log(listToAdd);
      console.log(listToRemove);

      await slide?.addBanners([...listToAdd], { transaction: t });
      await slide?.removeBanners([...listToRemove], { transaction: t });
    });
  }

  public async getSlideByLocation(location: string): Promise<SlideInstance> {
    const place = await locationDao.findByName(location);
    const slide = await Slide.findOne({
      where: { location_id: place.id },
      include: {
        model: Banner,
        as: "banners",
        include: [{ model: Media, as: "media" }],
      },
    });
    if (slide == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    return slide;
  }
}

export default SlideDao;
