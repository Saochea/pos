const express = require("express");
const Product = require("../controllers/ProductsController");
const upload = require("../middlewares/uploads");

const router = express.Router();

router
  .route("/products")
  .post(upload, Product.createNewProduct)
  .get(Product.findAll);
router.route("/product/:product_id").put(upload, Product.uppdateProduct);
router.route("/product/:product_id").delete(Product.delete);
router.route("/product/:product_id").get(Product.findOne);
router.route("/product/query").post(Product.queryProductByName);
router.route("/product_code/query").get(Product.queryProductByProductCode);
router.route("/image/:product_id").get(Product.findImgById);
router.route("/image/:product_id").put(Product.deleteImageOne);
router.route("/product_card").get(Product.productCard);
router.route("/api/procode/:productcode").get(Product.findByProcode);
router.route("/api/product-reports").get(Product.ProductReports);
router.route("/productcard").get(Product.findProductByNameAndCode);
router.route("/outofstock").get(Product.OutOfStockMsg);
router.route("/reorder").get(Product.reorder_msg);
router.route("/countItems").get(Product.itemsCount);
router.route("/view_products/:id").get(Product.viewById);
router.route("/stock_report").get(Product.stock_reports);
module.exports = router;