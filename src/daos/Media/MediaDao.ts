import HttpError from "../../helper/iHttpError";
import Media, { MediaInstance, MediaAttributes } from "../../models/Media";
import { fileNotFound, notFound, UPLOAD_DESTINATION } from "@shared/constants";
import { StatusCodes } from "http-status-codes";
import fs from "fs";
import { Op } from "sequelize";

class MediaDao {
  public async saveFileInfor(data: MediaAttributes): Promise<MediaInstance> {
    const media = await Media.create({ ...data });
    return media;
  }

  public async editFileInfor(
    filename: string,
    data: any
  ): Promise<MediaInstance> {
    const media = await Media.findOne({
      where: {
        filename: filename,
      },
    });
    if (media == null) throw new HttpError(StatusCodes.NOT_FOUND, fileNotFound);

    await media.update({
      ...data,
    });

    return media;
  }

  public async deleteFile(filename: string): Promise<void> {
    const media = await Media.findOne({
      where: {
        filename: filename,
      },
    });
    await media?.destroy();

    const filepath = `${UPLOAD_DESTINATION}/${filename}`;
    fs.unlinkSync(filepath);
  }

  public async search(query: string): Promise<MediaInstance[]> {
    const list = await Media.findAll({
      where: {
        [Op.or]: [
          { title: { [Op.like]: `%${query}%` } },
          { filename: { [Op.like]: `%${query}%` } },
        ],
      },
      order: [["createdAt", "DESC"]],
    });
    return list;
  }

  public async find(filename: string): Promise<MediaInstance> {
    const media = await Media.findOne({
      where: {
        filename,
      },
    });
    if (media == null) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    return media;
  }
}

export default MediaDao;
