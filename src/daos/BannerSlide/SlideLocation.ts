import { notFound } from "@shared/constants";
import { StatusCodes } from "http-status-codes";
import HttpError from "@helper/iHttpError";
import MediaDao from "@daos/Media/MediaDao";
import SlideLocation, {
  SlideLocationAttributes,
  SlideLocationInstance,
} from "@src/models/SlideLocation";
import Banner from "@src/models/Banner";
import Slide from "@src/models/Slide";

class SlideLocationDao {
  public async create(
    data: SlideLocationAttributes
  ): Promise<SlideLocationInstance> {
    const location = await SlideLocation.create({
      ...data,
    });
    return location;
  }

  public async edit(
    id: number,
    data: SlideLocationAttributes
  ): Promise<SlideLocationInstance> {
    const location = await SlideLocation.findByPk(id);
    if (!location) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    await location.update({ ...data });
    return location;
  }

  public async delete(id: number): Promise<void> {
    const location = await SlideLocation.findByPk(id);
    if (location == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    await location.destroy();
  }

  public async find(id: number): Promise<SlideLocationInstance> {
    const location = await SlideLocation.findByPk(id, {
      include: { model: Slide, as: "slide" },
    });
    if (location == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    return location;
  }

  public async search(): Promise<SlideLocationInstance[]> {
    let list = await SlideLocation.findAll({
      include: { model: Slide, as: "slide" },
    });
    return list;
  }

  public async findByName(query: string): Promise<SlideLocationInstance> {
    const location = await SlideLocation.findOne({
      where: { name: query },
    });
    if (location == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    return location;
  }
}

export default SlideLocationDao;
