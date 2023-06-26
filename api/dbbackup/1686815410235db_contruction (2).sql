-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 24, 2023 at 07:52 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_contruction`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `RowStockReport` (IN `qty_stock` INT, IN `search` VARCHAR(100))   BEGIN
	IF qty_stock = 0 THEN
		SELECT COUNt(*) AS totalRows FROM tblProducts WHERE tblProducts.product_code LIKE CONCAT('%',search,'%') AND tblProducts.qty = qty_stock;
    ELSE
    	SELECT COUNT(*) AS totalRows FROM tblProducts WHERE tblProducts.product_code LIKE CONCAT('%',search,'%') AND tblProducts.qty = tblProducts.reorder_number;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SaleInvoice_sp` (IN `id` INT)   SELECT tblProducts.product_name,concat(tblSaleDetails.qty_sales,' ',tblProductUnits.unit) AS qty,tblSaleDetails.qty_sales,tblProducts.price,
(tblSaleDetails.qty_sales*tblProducts.price) AS subtotal,tblUsers.username,tblSales.sale_date,tblInvoice.amount,tblInvoice.money_change,tblPayments.payment_type,
tblInvoice.invoice_number,tblCustomers.id AS customer_id,tblCustomers.customerName

FROM tblSaleDetails
INNER JOIN tblProducts ON tblSaleDetails.product_id = tblProducts.product_id
INNER JOIN tblSales ON tblSaleDetails.sale_id = tblSales.sale_id
INNER JOIN tblInvoice ON tblSales.invoice_id = tblInvoice.invoice_id
INNER JOIN tblProductUnits ON tblProducts.unit_id = tblProductUnits.id
LEFT JOIN tblUsers ON tblSales.user_id = tblUsers.id
LEFT JOIN tblCustomers ON tblSales.customer_id = tblCustomers.id
INNER JOIN tblPayments ON tblPayments.id = tblInvoice.payment_id
WHERE tblSales.sale_id = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Category` (IN `limits` INT, IN `page` INT, IN `search` VARCHAR(100))   BEGIN

	DECLARE skip_page INT;
    SET skip_page = limits*(page-1);
    
    SELECT *FROM tblCategories
    WHERE tblCategories.categoryName LIKE CONCAT('%',search,'%') OR tblCategories.id = search
    ORDER BY tblCategories.id 
    LIMIT limits OFFSET skip_page;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DeleteSale` (IN `id` INT)   BEGIN

	DELETE FROM tblInvoice WHERE tblInvoice.invoice_id = id;
    DELETE FROM tblSales WHERE tblSales.sale_id =id;
    DELETE FROM tblSaleDetails WHERE tblSaleDetails.sale_id = id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_FetchSaleProduct` (IN `id` INT)   SELECT tblProducts.product_name,tblProducts.product_id,tblProducts.product_image,tblProducts.qty AS old_qty,tblSaleDetails.qty_sales AS qty,tblProducts.price,tblProducts.unit_price,tblCategories.id AS category_id,tblInvoice.payment_id,tblCustomers.id AS customer_id
FROM tblSaleDetails
INNER JOIN tblProducts ON tblSaleDetails.product_id = tblProducts.product_id
INNER JOIN tblSales ON tblSaleDetails.sale_id = tblSales.sale_id
INNER JOIN tblInvoice ON tblSales.invoice_id = tblInvoice.invoice_id
LEFT JOIN tblUsers ON tblSales.user_id = tblUsers.id
INNER JOIN tblPayments ON tblPayments.id = tblInvoice.payment_id
LEFT JOIN tblCategories ON tblProducts.category_id = tblCategories.id
LEFT JOIN tblCustomers ON tblSales.customer_id = tblCustomers.id
WHERE tblSales.sale_id = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetRowCustomers` (IN `search` VARCHAR(30))   BEGIN
    
    SELECT COUNT(*) AS totalRows FROM tblCustomers;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetRowsCategory` (IN `search` VARCHAR(100))   BEGIN
    SELECT COUNT(*) AS totalRows FROM tblCategories
    WHERE tblCategories.categoryName LIKE CONCAT('%',search,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetRowSupplier` (IN `search` VARCHAR(100))   BEGIN
	
	SELECT COUNT(*) AS totalRows FROM tblSupplies
    WHERE tblSupplies.supName LIKE concat('%',search,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ItemCounts` ()   BEGIN
    
    SELECT  COUNT(*) AS total_sales FROM tblSales;
    SELECT COUNT(*) AS total_products  FROM tblProducts;
    SELECT COUNT(*) AS total_customers FROM tblCustomers;
    SELECT COUNT(*) AS total_categories FROM tblCategories;
   
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListSales` (IN `limits` INT, IN `page` INT, IN `user_id` INT(0), IN `role` BOOLEAN, IN `invoiceNumber` VARCHAR(100))   BEGIN 
	DECLARE skip_page INT;
    SET skip_page = (page-1)*limits;
   IF role THEN 
	SELECT tblSales.sale_date,tblInvoice.invoice_number,tblSales.sale_id,tblInvoice.invoice_id,tblCustomers.customerName,tblInvoice.amount,tblInvoice.money_change,SUM(tblProducts.price*tblSaleDetails.qty_sales) as totalPrice,tblInvoice.payment_id FROM tblSales
        INNER JOIN  tblInvoice ON tblInvoice.invoice_id = tblSales.invoice_id
        LEFT JOIN tblUsers ON tblSales.user_id = tblUsers.id
        INNER JOIN tblCustomers ON tblSales.customer_id = tblCustomers.id
        INNER JOIN tblSaleDetails ON tblSales.sale_id = tblSaleDetails.sale_id
        INNER JOIN tblProducts ON tblSaleDetails.product_id = tblProducts.product_id
        
        WHERE tblInvoice.invoice_number LIKE concat( '%',invoiceNumber,'%') AND role = 1
        GROUP BY (tblSaleDetails.sale_id)  
        ORDER BY tblInvoice.invoice_number DESC LIMIT limits OFFSET skip_page;
   		 ELSE
       SELECT tblSales.sale_date,tblInvoice.invoice_number,tblSales.sale_id,tblInvoice.invoice_id,tblCustomers.customerName,
       	tblInvoice.amount,tblInvoice.money_change,SUM(tblProducts.price*tblSaleDetails.qty_sales) as totalPrice,tblInvoice.payment_id FROM tblSales
        INNER JOIN  tblInvoice ON tblInvoice.invoice_id = tblSales.invoice_id
        INNER JOIN tblCustomers ON tblSales.customer_id = tblCustomers.id
        INNER JOIN tblSaleDetails ON tblSales.sale_id = tblSaleDetails.sale_id
        INNER JOIN tblProducts ON tblSaleDetails.product_id = tblProducts.product_id
        INNER JOIN tblUsers ON tblSales.user_id = tblUsers.id
        WHERE (tblInvoice.invoice_number LIKE concat( '%',invoiceNumber,'%') AND tblUsers.id = user_id) AND tblSales.sale_date = CURRENT_DATE()
        GROUP BY (tblSaleDetails.sale_id)  
        ORDER BY tblInvoice.invoice_number DESC LIMIT limits OFFSET skip_page;
   END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_List_Customers` (IN `limits` INT, IN `page` INT, IN `search` VARCHAR(30))   BEGIN
  DECLARE skip_page INT;
    SET skip_page = (page-1)*limits;
    
    SELECT *FROM tblCustomers 
    WHERE tblCustomers.customerName LIKE CONCAT('%',search,'%') OR tblCustomers.id = search
    ORDER BY tblCustomers.id
    LIMIT limits OFFSET skip_page;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_List_Users` (IN `limits` INT, IN `page` INT, IN `search` VARCHAR(30))   BEGIN
	DECLARE skip_page INT;
    SET skip_page = (page-1)*limits;
   
    SELECT tblUsers.id,username,email,phone_number,tblRoles.role_name,tblStatus.status FROM tblUsers 
    INNER JOIN tblRoles ON tblUsers.role_id = tblRoles.role_id
    INNER JOIN tblStatus ON tblUsers.status_id = tblStatus.id
    WHERE tblUsers.username LIKE CONCAT('%',search,'%') OR tblUsers.id = search
    ORDER BY tblUsers.id DESC
    LIMIT limits OFFSET skip_page;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ProductCard` (IN `search` VARCHAR(100))   BEGIN

	SELECT product_id,product_name,price,product_image,qty,product_code,category_id FROM tblProducts 
    WHERE (status = 1 AND qty>0) AND product_name LIKE concat('%',search,'%') OR product_code=search;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ProductPagination` (IN `search_val` VARCHAR(100))   BEGIN
  SELECT COUNT(*) AS TotalRows  FROM tblProducts 
  WHERE tblProducts.product_name LIKE CONCAT('%',search_val,'%') OR tblProducts.product_code = search_val
  ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ProductReportCategory` (IN `page_limits` INT, IN `page` INT, IN `categoryId` INT, IN `search` VARCHAR(100))   BEGIN
	DECLARE skip_page INT;
	SET skip_page = (page-1)*page_limits;
	select `db_contruction`.`tblProducts`.`product_id` AS `product_id`,tblCategories.categoryName,`db_contruction`.`tblProducts`.`product_code` AS `product_code`,`db_contruction`.`tblProducts`.`product_name` AS `product_name`,sum(`db_contruction`.`tblSaleDetails`.`qty_sales`) AS `qty_sales`,`db_contruction`.`tblProductUnits`.`unit` AS `unit`,sum(`db_contruction`.`tblSaleDetails`.`qty_sales`) * `db_contruction`.`tblProducts`.`unit_price` AS `cost`,sum(`db_contruction`.`tblSaleDetails`.`qty_sales`) * `db_contruction`.`tblProducts`.`price` AS `revenue`,sum(`db_contruction`.`tblSaleDetails`.`qty_sales`) * `db_contruction`.`tblProducts`.`price` - sum(`db_contruction`.`tblSaleDetails`.`qty_sales`) * `db_contruction`.`tblProducts`.`unit_price` AS `profit`,`db_contruction`.`tblProducts`.`qty` AS `qty` from ((`db_contruction`.`tblSaleDetails` left join `db_contruction`.`tblProducts` on(`db_contruction`.`tblSaleDetails`.`product_id` = `db_contruction`.`tblProducts`.`product_id`)) join `db_contruction`.`tblProductUnits` on(`db_contruction`.`tblProducts`.`unit_id` = `db_contruction`.`tblProductUnits`.`id`))
 INNER JOIN tblCategories ON tblProducts.category_id = tblCategories.id
 WHERE  tblProducts.product_name LIKE concat('%',search,'%') AND tblCategories.id =  categoryId
 group by `db_contruction`.`tblSaleDetails`.`product_id`
 LIMIT page_limits OFFSET skip_page;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ProductReports` (IN `page_limits` INT, IN `page` INT, IN `search` VARCHAR(100))   BEGIN
	DECLARE skip_page INT;
	SET skip_page = (page-1)*page_limits;
	select `db_contruction`.`tblProducts`.`product_id` AS `product_id`,tblCategories.categoryName,`db_contruction`.`tblProducts`.`product_code` AS `product_code`,`db_contruction`.`tblProducts`.`product_name` AS `product_name`,sum(`db_contruction`.`tblSaleDetails`.`qty_sales`) AS `qty_sales`,`db_contruction`.`tblProductUnits`.`unit` AS `unit`,sum(`db_contruction`.`tblSaleDetails`.`qty_sales`) * `db_contruction`.`tblProducts`.`unit_price` AS `cost`,sum(`db_contruction`.`tblSaleDetails`.`qty_sales`) * `db_contruction`.`tblProducts`.`price` AS `revenue`,sum(`db_contruction`.`tblSaleDetails`.`qty_sales`) * `db_contruction`.`tblProducts`.`price` - sum(`db_contruction`.`tblSaleDetails`.`qty_sales`) * `db_contruction`.`tblProducts`.`unit_price` AS `profit`,`db_contruction`.`tblProducts`.`qty` AS `qty` from ((`db_contruction`.`tblSaleDetails` left join `db_contruction`.`tblProducts` on(`db_contruction`.`tblSaleDetails`.`product_id` = `db_contruction`.`tblProducts`.`product_id`)) join `db_contruction`.`tblProductUnits` on(`db_contruction`.`tblProducts`.`unit_id` = `db_contruction`.`tblProductUnits`.`id`))
 INNER JOIN tblCategories ON tblProducts.category_id = tblCategories.id
 WHERE tblProducts.product_code = search OR tblProducts.product_name LIKE concat('%',search,'%') 
 group by `db_contruction`.`tblSaleDetails`.`product_id`
 LIMIT page_limits OFFSET skip_page;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_RowsListSale` (IN `invoiceNumber` VARCHAR(100))   BEGIN 
	SELECT COUNT(*) AS totalRows FROM tblSales
	INNER JOIN  tblInvoice ON tblInvoice.invoice_id = tblSales.sale_id
    INNER JOIN tblCustomers ON tblSales.customer_id = tblCustomers.id
    WHERE tblInvoice.invoice_number LIKE concat( '%',invoiceNumber,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_RowsProReports` (IN `search` VARCHAR(100))   BEGIN
	SELECT COUNT(*) AS TotalRows FROM V_ProductReports
  WHERE V_ProductReports.product_name  LIKE concat('%',search,'%');

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Row_Users` (IN `search` VARCHAR(30))   BEGIN
	
	SELECT COUNT(*) AS totalRows FROM tblUsers
    WHERE username LIKE concat( '%',search,'%');
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SaleReports` (IN `limits` INT, IN `page` INT, IN `invoiceNumber` VARCHAR(100))   BEGIN 
	DECLARE skip_page INT;
    SET skip_page = (page-1)*limits;
	SELECT tblSales.sale_date,tblInvoice.invoice_number,tblSales.sale_id,tblInvoice.invoice_id,tblCustomers.customerName,tblInvoice.amount,
    tblInvoice.money_change,SUM(tblProducts.price*tblSaleDetails.qty_sales) as totalPrice,tblSales.sale_date,tblPayments.payment_type
    FROM tblSales
	INNER JOIN  tblInvoice ON tblInvoice.invoice_id = tblSales.invoice_id
    INNER JOIN tblCustomers ON tblSales.customer_id = tblCustomers.id
    INNER JOIN tblSaleDetails ON tblSales.sale_id = tblSaleDetails.sale_id
    INNER JOIN tblProducts ON tblSaleDetails.product_id = tblProducts.product_id
    INNER JOIN tblPayments ON tblInvoice.payment_id = tblPayments.id
    WHERE tblInvoice.invoice_number LIKE concat( '%',invoiceNumber,'%')
    GROUP BY (tblSaleDetails.sale_id) 
    ORDER BY tblInvoice.invoice_number DESC LIMIT limits OFFSET skip_page ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SaleReportsWidthDate` (IN `limits` INT, IN `page` INT, IN `invoiceNumber` VARCHAR(100), IN `start_date` DATE, IN `end_date` DATE)   BEGIN 
	DECLARE skip_page INT;
    SET skip_page = (page-1)*limits;
	SELECT tblSales.sale_date,tblInvoice.invoice_number,tblSales.sale_id,tblInvoice.invoice_id,tblCustomers.customerName,tblInvoice.amount,
    tblInvoice.money_change,SUM(tblProducts.price*tblSaleDetails.qty_sales) as totalPrice,tblSales.sale_date,tblPayments.payment_type
    FROM tblSales
	INNER JOIN  tblInvoice ON tblInvoice.invoice_id = tblSales.invoice_id
    INNER JOIN tblCustomers ON tblSales.customer_id = tblCustomers.id
    INNER JOIN tblSaleDetails ON tblSales.sale_id = tblSaleDetails.sale_id
    INNER JOIN tblProducts ON tblSaleDetails.product_id = tblProducts.product_id
    INNER JOIN tblPayments ON tblInvoice.payment_id = tblPayments.id
    WHERE tblInvoice.invoice_number LIKE CONCAT('%',invoiceNumber,'%') AND (tblSales.sale_date BETWEEN start_date AND end_date )
    GROUP BY (tblSaleDetails.sale_id) 
    ORDER BY tblInvoice.invoice_number DESC LIMIT limits OFFSET skip_page ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SearchProduct` (IN `search_val` VARCHAR(255), IN `limit_page` INT, IN `page` INT)   BEGIN
DECLARE page_offset INT;
SET page_offset = (page-1)*limit_page;
 SELECT `tblProducts`.`product_image` AS `product_image`,tblStatus.status ,`tblProducts`.`product_id` AS `product_id`, `tblProducts`.`product_name` AS `product_name`, `tblProducts`.`product_code` AS `product_code`, `tblCategories`.`categoryName` AS `categoryName`, `tblBrands`.`brandName` AS `brandName`, `tblProductUnits`.`unit` AS `unit`, `tblProducts`.`unit_price` AS `unit_price`, `tblProducts`.`price` AS `price`, `tblProducts`.`qty` AS `qty`, `tblProducts`.`reorder_number` AS `reorder_number` FROM (((`tblProducts` left join `tblCategories` on(`tblProducts`.`category_id` = `tblCategories`.`id`)) left join `tblBrands` on(`tblProducts`.`brand_id` = `tblBrands`.`id`)) left join `tblProductUnits` on(`tblProducts`.`unit_id` = `tblProductUnits`.`id`)) INNER JOIN tblStatus ON tblStatus.id = tblProducts.status
 WHERE tblProducts.product_name LIKE concat('%',search_val,'%') OR tblProducts.product_code = `search_val`
 LIMIT limit_page OFFSET page_offset;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Supplier` (IN `limits` INT, IN `page` INT, IN `search` VARCHAR(100))   BEGIN
	DECLARE skip_page INT;
    SET skip_page = (page-1)*limits;
	SELECT *FROM tblSupplies
    WHERE tblSupplies.supName LIKE concat('%',search,'%')
     ORDER BY tblSupplies.id DESC
    LIMIT limits OFFSET skip_page;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `StockReports` (IN `limits` INT, IN `qty_stock` INT, IN `search` VARCHAR(100), IN `page` INT)   BEGIN
	DECLARE skip INT;
    SET skip = (page-1)*limits;
    
	IF qty_stock = 0 THEN
	SELECT tblProducts.product_id,tblProducts.product_code,tblProducts.product_name,tblProducts.qty,tblBrands.brandName,tblCategories.categoryName
    ,tblSupplies.companyName,tblSupplies.supName,tblSupplies.phone,tblProducts.unit_price
    FROM tblProducts 
    INNER JOIN tblCategories ON tblProducts.category_id = tblCategories.id
    LEFT JOIN tblBrands ON tblProducts.brand_id = tblBrands.id
    LEFT JOIN tblSupplies ON tblProducts.sub_id = tblSupplies.id
    WHERE tblProducts.product_code LIKE CONCAT('%',search,'%') AND tblProducts.qty = qty_stock 
    LIMIT limits OFFSET skip;
    ELSE
    
            SELECT 					tblProducts.product_id,tblProducts.product_code,tblProducts.product_name,tblProducts.qty,tblBrands.brandName,tblCategories.categoryName 
             ,tblSupplies.companyName,tblSupplies.supName,tblSupplies.phone,tblProducts.unit_price
            FROM tblProducts 
        INNER JOIN tblCategories ON tblProducts.category_id = tblCategories.id
        LEFT JOIN tblBrands ON tblProducts.brand_id = tblBrands.id
        LEFT JOIN tblSupplies ON tblProducts.sub_id = tblSupplies.id
        WHERE tblProducts.product_code LIKE CONCAT('%',search,'%') AND (tblProducts.qty <= tblProducts.reorder_number AND tblProducts.qty>0)
    	LIMIT limits OFFSET skip;
    END IF;
 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCustomerData` (IN `p_customerName` VARCHAR(100), IN `p_email` VARCHAR(100), IN `p_phoneNumber` VARCHAR(20), IN `p_address` VARCHAR(200), IN `p_id` INT)   BEGIN
    UPDATE tblCustomers
    SET customerName = p_customerName,
    	email = p_email,
        phoneNumber = p_phoneNumber,
        address = p_address
    WHERE  id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_product_by_id` (IN `p_id` INT)   BEGIN
	SELECT *FROM getAllProducts WHERE getAllProducts.product_id = p_id;
End$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `AuditSales`
--

CREATE TABLE `AuditSales` (
  `action_type` varchar(30) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `qty_sales` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `AuditSales`
--

INSERT INTO `AuditSales` (`action_type`, `timestamp`, `qty_sales`, `product_id`, `sale_id`) VALUES
('UPDATE', '2023-05-03 07:59:58', 2, 1, 18),
('UPDATE', '2023-05-03 07:59:58', 2, 2, 18),
('UPDATE', '2023-05-09 07:05:36', 1, 1, 22),
('UPDATE', '2023-05-09 07:05:36', 1, 2, 22),
('UPDATE', '2023-05-09 07:27:52', 1, 1, 24),
('UPDATE', '2023-05-09 07:27:52', 1, 2, 24),
('UPDATE', '2023-05-09 08:24:33', 1, 1, 25),
('UPDATE', '2023-05-09 08:24:33', 1, 2, 25),
('UPDATE', '2023-05-09 08:33:14', 1, 1, 14),
('UPDATE', '2023-05-09 08:33:14', 1, 2, 14),
('UPDATE', '2023-05-09 08:35:46', 20, 1, 16),
('UPDATE', '2023-05-09 08:35:46', 20, 2, 16),
('UPDATE', '2023-05-09 08:45:42', 1, 1, 15),
('UPDATE', '2023-05-09 08:45:42', 1, 2, 15);

-- --------------------------------------------------------

--
-- Stand-in structure for view `getAllProducts`
-- (See below for the actual view)
--
CREATE TABLE `getAllProducts` (
`product_image` varchar(250)
,`product_id` int(11)
,`product_name` varchar(200)
,`product_code` varchar(100)
,`status` varchar(10)
,`categoryName` varchar(250)
,`brandName` varchar(200)
,`unit` varchar(20)
,`unit_price` float
,`price` float
,`qty` int(11)
,`reorder_number` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `tblBrands`
--

CREATE TABLE `tblBrands` (
  `id` int(11) NOT NULL,
  `brandName` varchar(200) NOT NULL,
  `desc` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblBrands`
--

INSERT INTO `tblBrands` (`id`, `brandName`, `desc`) VALUES
(1, 'K cement', ''),
(2, 'ស៊ីម៉ងត៍អូឌ', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblCategories`
--

CREATE TABLE `tblCategories` (
  `id` int(11) NOT NULL,
  `categoryName` varchar(250) NOT NULL,
  `desc` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblCategories`
--

INSERT INTO `tblCategories` (`id`, `categoryName`, `desc`) VALUES
(2, 'ដែក', ''),
(3, 'សុីម៉ងត៍', ''),
(4, 'ផ្លែរកាត់ដែក ', ''),
(5, 'ក្ដាបន្ទះពេជ្រ ស', ''),
(6, 'ផ្លែរកាត់ការ៉ូ', ''),
(7, 'ផ្លែរកាតបេតុង', ''),
(8, 'ជក់លាបថ្នាំ', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblCurrency`
--

CREATE TABLE `tblCurrency` (
  `cur_id` int(11) NOT NULL,
  `cur_kh` float NOT NULL,
  `cur_dollar` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblCurrency`
--

INSERT INTO `tblCurrency` (`cur_id`, `cur_kh`, `cur_dollar`) VALUES
(1, 4150, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblCustomers`
--

CREATE TABLE `tblCustomers` (
  `id` int(11) NOT NULL,
  `customerName` varchar(100) NOT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblCustomers`
--

INSERT INTO `tblCustomers` (`id`, `customerName`, `phoneNumber`, `email`, `address`) VALUES
(1, 'General', NULL, NULL, NULL),
(2, 'Dara', '090870148', 'dara@gmail.com', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblInvoice`
--

CREATE TABLE `tblInvoice` (
  `invoice_id` int(11) NOT NULL,
  `invoice_number` varchar(250) DEFAULT NULL,
  `payment_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `money_change` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblInvoice`
--

INSERT INTO `tblInvoice` (`invoice_id`, `invoice_number`, `payment_id`, `amount`, `money_change`) VALUES
(17, 'PSS2023430017', 1, 27, 0),
(18, 'PSS2023430018', 2, 67, 0),
(19, 'PSS202354019', 2, 27, 0),
(20, 'PSS202356020', 1, 29.5, 0),
(21, 'PSS202358021', 1, 45, 0),
(22, 'PSS202358022', 1, 41, 0),
(23, 'PSS202359023', 1, 27, 0),
(24, 'PSS202359024', 1, 40, 0),
(25, 'PSS202359025', 1, 27, 0),
(26, 'PSS202359026', 1, 27, 0),
(27, 'PSS202359027', 1, 27, 0),
(28, 'PSS2023513028', 1, 29.5, 0),
(29, 'PSS2023515029', 1, 29.5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tblPayments`
--

CREATE TABLE `tblPayments` (
  `id` int(11) NOT NULL,
  `payment_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblPayments`
--

INSERT INTO `tblPayments` (`id`, `payment_type`) VALUES
(1, 'Cash'),
(2, 'ABA');

-- --------------------------------------------------------

--
-- Table structure for table `tblProducts`
--

CREATE TABLE `tblProducts` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT 0,
  `sub_id` int(11) DEFAULT 0,
  `unit_id` int(11) NOT NULL DEFAULT 0,
  `product_code` varchar(100) DEFAULT NULL,
  `product_name` varchar(200) DEFAULT NULL,
  `qty` int(11) DEFAULT 0,
  `unit_price` float DEFAULT 0,
  `price` float DEFAULT 0,
  `exp_date` date DEFAULT NULL,
  `product_image` varchar(250) DEFAULT NULL,
  `desc` varchar(250) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `reorder_number` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblProducts`
--

INSERT INTO `tblProducts` (`product_id`, `category_id`, `brand_id`, `sub_id`, `unit_id`, `product_code`, `product_name`, `qty`, `unit_price`, `price`, `exp_date`, `product_image`, `desc`, `status`, `reorder_number`) VALUES
(1, 3, 0, 0, 2, 'OUD1122', 'សុីម៉ង់ត័ K Cement', 4, 10, 13, '2023-05-15', 'images/1683795777311KCment.png', '', 1, 20),
(2, 3, 0, 0, 3, 'KC02233', 'សុីម៉ងត៍KCement', 22, 13, 14, '2023-05-11', 'images/default.png', '', 1, 10),
(24, 3, 0, 0, 2, '203456', 'សុីម៉ង់ត័', 8, 2, 2.5, '2023-05-11', 'images/1683795801343Screenshot from 2023-05-08 14-57-28.png', '', 1, 12);

-- --------------------------------------------------------

--
-- Table structure for table `tblProductUnits`
--

CREATE TABLE `tblProductUnits` (
  `id` int(11) NOT NULL,
  `unit` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblProductUnits`
--

INSERT INTO `tblProductUnits` (`id`, `unit`) VALUES
(1, 'others'),
(2, 'ការ៉ុង'),
(3, 'តោន'),
(4, 'បន្ទះ'),
(5, 'សន្លឺក');

-- --------------------------------------------------------

--
-- Table structure for table `tblRoles`
--

CREATE TABLE `tblRoles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblRoles`
--

INSERT INTO `tblRoles` (`role_id`, `role_name`) VALUES
(1, 'Admin'),
(2, 'User');

-- --------------------------------------------------------

--
-- Table structure for table `tblSaleDetails`
--

CREATE TABLE `tblSaleDetails` (
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty_sales` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblSaleDetails`
--

INSERT INTO `tblSaleDetails` (`sale_id`, `product_id`, `qty_sales`) VALUES
(17, 1, 1),
(17, 2, 1),
(18, 1, 3),
(18, 2, 2),
(19, 1, 1),
(19, 2, 1),
(20, 1, 1),
(20, 2, 1),
(20, 24, 1),
(21, 1, 2),
(21, 2, 1),
(21, 24, 2),
(22, 1, 1),
(22, 2, 2),
(23, 1, 1),
(23, 2, 1),
(24, 1, 2),
(24, 2, 1),
(25, 1, 1),
(25, 2, 1),
(26, 1, 1),
(26, 2, 1),
(27, 1, 1),
(27, 2, 1),
(28, 1, 1),
(28, 2, 1),
(28, 24, 1),
(29, 1, 1),
(29, 2, 1),
(29, 24, 1);

--
-- Triggers `tblSaleDetails`
--
DELIMITER $$
CREATE TRIGGER `RecordSaleAction` AFTER DELETE ON `tblSaleDetails` FOR EACH ROW INSERT INTO AuditSales (action_type,sale_id,qty_sales,product_id,timestamp)
VALUES("UPDATE",OLD.sale_id,OLD.qty_sales,OLD.product_id,CURRENT_TIMESTAMP)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_sale` AFTER DELETE ON `tblSaleDetails` FOR EACH ROW BEGIN
   UPDATE tblProducts SET tblProducts.qty = tblProducts.qty + OLD.qty_sales WHERE tblProducts.product_id = OLD.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_qty` AFTER INSERT ON `tblSaleDetails` FOR EACH ROW UPDATE tblProducts SET qty = qty-new.qty_sales WHERE product_id = new.product_id AND (qty-new.qty_sales)>=0
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_sale` AFTER UPDATE ON `tblSaleDetails` FOR EACH ROW BEGIN
    UPDATE tblProducts SET tblProducts.qty = (tblProducts.qty+OLD.qty_sales)-NEW.qty_sales;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblSales`
--

CREATE TABLE `tblSales` (
  `sale_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `invoice_id` int(11) NOT NULL,
  `sale_date` date NOT NULL,
  `desc` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblSales`
--

INSERT INTO `tblSales` (`sale_id`, `user_id`, `customer_id`, `invoice_id`, `sale_date`, `desc`) VALUES
(17, 4, 2, 17, '2023-04-30', ''),
(18, 10, 1, 18, '2023-04-30', ''),
(19, 10, 1, 19, '2023-05-04', ''),
(20, 4, 1, 20, '2023-05-06', ''),
(21, 4, 1, 21, '2023-05-08', ''),
(22, 4, 1, 22, '2023-05-08', ''),
(23, 4, 1, 23, '2023-05-09', ''),
(24, 10, 1, 24, '2023-05-09', ''),
(25, 4, 2, 25, '2023-05-09', ''),
(26, 4, 1, 26, '2023-05-09', ''),
(27, 4, 1, 27, '2023-05-09', ''),
(28, 10, 1, 28, '2023-05-13', ''),
(29, 4, 1, 29, '2023-05-15', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblStatus`
--

CREATE TABLE `tblStatus` (
  `id` int(11) NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblStatus`
--

INSERT INTO `tblStatus` (`id`, `status`) VALUES
(1, 'Enable'),
(2, 'Disable');

-- --------------------------------------------------------

--
-- Table structure for table `tblSupplies`
--

CREATE TABLE `tblSupplies` (
  `id` int(11) NOT NULL,
  `supName` varchar(250) NOT NULL,
  `companyName` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `phone` varchar(250) NOT NULL,
  `address` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblSupplies`
--

INSERT INTO `tblSupplies` (`id`, `supName`, `companyName`, `email`, `phone`, `address`) VALUES
(1, 'Jonh Doe', 'KCM', '', '', ''),
(2, 'sokha', 'ABC', '', '090908765', ''),
(5, 'sokha', 'ABC', '', '090908765', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblUsers`
--

CREATE TABLE `tblUsers` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `phone_number` varchar(100) DEFAULT NULL,
  `token` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblUsers`
--

INSERT INTO `tblUsers` (`id`, `role_id`, `status_id`, `username`, `password`, `email`, `phone_number`, `token`) VALUES
(4, 1, 1, 'saochea', '$2b$10$ZV.nuZ2muZhQUCsdtL9ksukKesmiUWVd3JBFWhs1OvKIetvtq2uci', 'saocheaphan@gmail.com', '09087456', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOjQsInVzZXJuYW1lIjoic2FvY2hlYSIsImVtYWlsIjoic2FvY2hlYXBoYW5AZ21haWwuY29tIiwicm9sZSI6IkFkbWluIiwiaWF0IjoxNjg0NDkzNzkyLCJleHAiOjE2ODQ1ODAxOTJ9.VKIZPkxQG2rhzh3oPFg1rB4WyPyZUA71sK1GGkLs_X4'),
(10, 2, 1, 'chea@#', '$2b$10$qJuBZLwHk0/gWvdZHBUch.GDp8m3ameNRz6Msi18yLrsfWZqVKdxu', 'dara@gmail.com', '908755', NULL),
(16, 1, 2, 'netfighter', '$2b$10$ErpcXibhWTRGZuw5mLCm7eAWukqrZACiexIWPaOuv/CZi52dJoWcm', '', '', NULL),
(17, 1, 1, 'mony', '$2b$10$S57Le0bMoUAUwp7sxxroee8m8O2agC2yQ4Wk/z8gU0asodCTAgZp2', 'saocheaphan@gmail', '', NULL),
(18, 2, 1, 'nith', '$2b$10$QV0Ij0vYzrPMKusmxcCh6usjbrp8lKc5VRM0tsBC9wqgyZZpZMcQG', 'hoeurnphanith@gmail.com', '', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOjE4LCJpYXQiOjE2ODI4NDY0MzQsImV4cCI6MTY4Mjg0NjYxNH0._PNc0Z4r9pbxsv02xLktN1LINvfJCoL9L2CJ-o7LSLU');

-- --------------------------------------------------------

--
-- Stand-in structure for view `V_ChartDayReports`
-- (See below for the actual view)
--
CREATE TABLE `V_ChartDayReports` (
`totalAmount` double
,`Day` varchar(32)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `V_ProductReports`
-- (See below for the actual view)
--
CREATE TABLE `V_ProductReports` (
`product_id` int(11)
,`product_code` varchar(100)
,`product_name` varchar(200)
,`qty_sales` decimal(32,0)
,`unit` varchar(20)
,`cost` double
,`revenue` double
,`profit` double
,`qty` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `V_todaySale`
-- (See below for the actual view)
--
CREATE TABLE `V_todaySale` (
`product_code` varchar(100)
,`product_name` varchar(200)
,`qty` varchar(59)
,`cost` double
,`revenue` double
,`profit` double
,`sale_date` date
);

-- --------------------------------------------------------

--
-- Structure for view `getAllProducts`
--
DROP TABLE IF EXISTS `getAllProducts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `getAllProducts`  AS SELECT `tblProducts`.`product_image` AS `product_image`, `tblProducts`.`product_id` AS `product_id`, `tblProducts`.`product_name` AS `product_name`, `tblProducts`.`product_code` AS `product_code`, `tblStatus`.`status` AS `status`, `tblCategories`.`categoryName` AS `categoryName`, `tblBrands`.`brandName` AS `brandName`, `tblProductUnits`.`unit` AS `unit`, `tblProducts`.`unit_price` AS `unit_price`, `tblProducts`.`price` AS `price`, `tblProducts`.`qty` AS `qty`, `tblProducts`.`reorder_number` AS `reorder_number` FROM ((((`tblProducts` left join `tblCategories` on(`tblProducts`.`category_id` = `tblCategories`.`id`)) left join `tblBrands` on(`tblProducts`.`brand_id` = `tblBrands`.`id`)) left join `tblProductUnits` on(`tblProducts`.`unit_id` = `tblProductUnits`.`id`)) join `tblStatus` on(`tblStatus`.`id` = `tblProducts`.`status`))  ;

-- --------------------------------------------------------

--
-- Structure for view `V_ChartDayReports`
--
DROP TABLE IF EXISTS `V_ChartDayReports`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `V_ChartDayReports`  AS SELECT sum(`tblInvoice`.`amount`) AS `totalAmount`, date_format(`tblSales`.`sale_date`,'%a') AS `Day` FROM (`tblSales` join `tblInvoice` on(`tblInvoice`.`invoice_id` = `tblSales`.`invoice_id`)) GROUP BY date_format(`tblSales`.`sale_date`,'%a')  ;

-- --------------------------------------------------------

--
-- Structure for view `V_ProductReports`
--
DROP TABLE IF EXISTS `V_ProductReports`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `V_ProductReports`  AS SELECT `tblProducts`.`product_id` AS `product_id`, `tblProducts`.`product_code` AS `product_code`, `tblProducts`.`product_name` AS `product_name`, sum(`tblSaleDetails`.`qty_sales`) AS `qty_sales`, `tblProductUnits`.`unit` AS `unit`, sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`unit_price` AS `cost`, sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`price` AS `revenue`, sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`price` - sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`unit_price` AS `profit`, `tblProducts`.`qty` AS `qty` FROM ((`tblSaleDetails` left join `tblProducts` on(`tblSaleDetails`.`product_id` = `tblProducts`.`product_id`)) join `tblProductUnits` on(`tblProducts`.`unit_id` = `tblProductUnits`.`id`)) GROUP BY `tblSaleDetails`.`product_id``product_id`  ;

-- --------------------------------------------------------

--
-- Structure for view `V_todaySale`
--
DROP TABLE IF EXISTS `V_todaySale`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `V_todaySale`  AS SELECT `tblProducts`.`product_code` AS `product_code`, `tblProducts`.`product_name` AS `product_name`, concat(sum(`tblSaleDetails`.`qty_sales`),' ( ',`tblProductUnits`.`unit`,' ) ') AS `qty`, sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`unit_price` AS `cost`, sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`price` AS `revenue`, sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`price` - sum(`tblSaleDetails`.`qty_sales`) * `tblProducts`.`unit_price` AS `profit`, curdate() AS `sale_date` FROM (((`tblSales` join `tblSaleDetails` on(`tblSaleDetails`.`sale_id` = `tblSales`.`sale_id`)) join `tblProducts` on(`tblSaleDetails`.`product_id` = `tblProducts`.`product_id`)) left join `tblProductUnits` on(`tblProducts`.`unit_id` = `tblProductUnits`.`id`)) WHERE `tblSales`.`sale_date` = curdate() GROUP BY `tblProducts`.`product_code``product_code`  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblBrands`
--
ALTER TABLE `tblBrands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblCategories`
--
ALTER TABLE `tblCategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblCurrency`
--
ALTER TABLE `tblCurrency`
  ADD PRIMARY KEY (`cur_id`);

--
-- Indexes for table `tblCustomers`
--
ALTER TABLE `tblCustomers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblInvoice`
--
ALTER TABLE `tblInvoice`
  ADD PRIMARY KEY (`invoice_id`);

--
-- Indexes for table `tblPayments`
--
ALTER TABLE `tblPayments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblProducts`
--
ALTER TABLE `tblProducts`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `tblProductUnits`
--
ALTER TABLE `tblProductUnits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblRoles`
--
ALTER TABLE `tblRoles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `tblSaleDetails`
--
ALTER TABLE `tblSaleDetails`
  ADD PRIMARY KEY (`sale_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `tblSales`
--
ALTER TABLE `tblSales`
  ADD PRIMARY KEY (`sale_id`),
  ADD UNIQUE KEY `invoice_id` (`invoice_id`);

--
-- Indexes for table `tblStatus`
--
ALTER TABLE `tblStatus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblSupplies`
--
ALTER TABLE `tblSupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblUsers`
--
ALTER TABLE `tblUsers`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tblBrands`
--
ALTER TABLE `tblBrands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblCategories`
--
ALTER TABLE `tblCategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tblCurrency`
--
ALTER TABLE `tblCurrency`
  MODIFY `cur_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblCustomers`
--
ALTER TABLE `tblCustomers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblInvoice`
--
ALTER TABLE `tblInvoice`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `tblPayments`
--
ALTER TABLE `tblPayments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblProducts`
--
ALTER TABLE `tblProducts`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tblProductUnits`
--
ALTER TABLE `tblProductUnits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblRoles`
--
ALTER TABLE `tblRoles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblSales`
--
ALTER TABLE `tblSales`
  MODIFY `sale_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `tblStatus`
--
ALTER TABLE `tblStatus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblSupplies`
--
ALTER TABLE `tblSupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblUsers`
--
ALTER TABLE `tblUsers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblSaleDetails`
--
ALTER TABLE `tblSaleDetails`
  ADD CONSTRAINT `tblSaleDetails_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `tblSales` (`sale_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tblSaleDetails_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `tblProducts` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
