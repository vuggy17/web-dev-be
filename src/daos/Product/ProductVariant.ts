import HttpError from "@helper/iHttpError";
import { notFound } from "@shared/constants";
import Media, { MediaInstance } from "@src/models/Media";
import Product from "@src/models/Product";
import ProductVariant, {
  ProductVariantAttributes,
  ProductVariantInstance,
} from "@src/models/ProductVariant";
import { StatusCodes } from "http-status-codes";
import { Op } from "sequelize";
import ProductDao from "./Product";

const productDao = new ProductDao();

class ProductVariantDao {
  public async create(
    data: ProductVariantAttributes
  ): Promise<ProductVariantInstance> {
    let product = null;
    if (data.product_id) {
      product = await Product.findOne({
        where: {
          id: data.product_id,
        },
      });
    }

    if (!product) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    const variant = await ProductVariant.create({ ...data });
    return variant;
  }

  public async edit(
    query: any,
    data: ProductVariantAttributes
  ): Promise<ProductVariantInstance> {
    const variant = await ProductVariant.findOne({
      where: {
        id: query,
      },
    });
    if (!variant) throw new HttpError(StatusCodes.NOT_FOUND, notFound);
    await variant.update({ ...data });
    return variant;
  }

  public async delete(query: any): Promise<void> {
    const variant = await ProductVariant.findOne({
      where: {
        id: query,
      },
    });
    await variant?.destroy();
  }
}

export default ProductVariantDao;
