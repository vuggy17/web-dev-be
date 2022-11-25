import { notFound } from "@shared/constants";
import { StatusCodes } from "http-status-codes";
import HttpError from "@helper/iHttpError";
import MediaDao from "@daos/Media/MediaDao";
import Banner, {
  BannerCreationAttributes,
  BannerInstance,
} from "@src/models/Banner";
import Media from "@src/models/Media";

const mediaDao = new MediaDao();

class BannerDao {
  public async create(data: BannerCreationAttributes): Promise<BannerInstance> {
    const file = await mediaDao.find(data.media_name);
    if (!file) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    const banner = await Banner.create({
      ...data,
      media_name: file.filename ?? data.media_name,
    });
    return banner;
  }

  public async edit(
    id: number,
    data: BannerCreationAttributes
  ): Promise<BannerInstance> {
    const file = data.media_name ? await mediaDao.find(data.media_name) : null;
    const banner = await Banner.findByPk(id);
    if ((!file && data.media_name) || !banner)
      throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    await banner.update({
      ...data,
      media_name: file?.filename ?? data.media_name,
    });
    return banner;
  }

  public async delete(id: number): Promise<void> {
    const banner = await Banner.findByPk(id);
    if (banner == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    await banner.destroy();
  }

  public async find(id: number): Promise<BannerInstance> {
    const banner = await Banner.findByPk(id, {
      include: [{ model: Media, as: "media" }],
    });
    if (banner == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    return banner;
  }

  public async search(): Promise<BannerInstance[]> {
    let list = await Banner.findAll({
      include: [{ model: Media, as: "media" }],
    });

    return list;
  }
}

export default BannerDao;
