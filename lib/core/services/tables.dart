part of "database.dart";

/// user (user_id, firebaseUid ,username, password, , contact, account_type)
/// desc :  the system can be access by three user groups namely the administrator, cashier and inventory officer. Information of the user will be stored in the tbl user
/// columns  6:
/// (1) user_id is the foreign key of the table,
/// (2) firebaseUid: is
/// (2) username and
/// (3) password is the combination used to access the system,
/// (4) designation refers to the position of the user in the company,
/// (5) contact is to the contact number of the user,
/// (6) account_type refers to the access type of the user to the system (admin has full access, cashier is only for POS module, and inventory officer for purchase and receiving of items.)

@DataClassName("User")
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firebaseUid => text()();
  TextColumn get username => text().withLength(max: 30)();
  TextColumn get password => text().withLength(max: 30)();
  TextColumn get contact => text().withLength(max: 10)();
  IntColumn get accountType => intEnum<AccountType>()();
}

/// product(product_id,product_code,product_name,unit_id,category_id,unit_in_stock,unit_price,discount_percentage,reorder_level,user_id)
/// desc: the list of products of the store will be recorded and stored in the table product
/// 10 columns:
/// product_id: is the primary key of the table it serves as the unique value of the table
/// product_code: is the barcode of the product
/// product_name: s for the name of the item or product
/// unit_id: is a foreign key that links to the tbl unit table
/// category_id: is another foreign key that connects to the tbl category table
/// unit_in_stock:  is the quantity of items available in the inventory,
/// unit_price:  is the price or amount per unit
/// discount_percentage: is the discount of product in percent,
/// reorder_level: is the number that will notify the system if the item or products needs to be reorder
/// user_id:  refers to the user who encoded the item information.
@DataClassName("Product")
class Products extends Table {
  IntColumn get id => integer().named("product_id").autoIncrement()();
  TextColumn get code => text().named("product_code")();
  TextColumn get name => text().named("product_name")();
  IntColumn get categoryId => integer().references(ProductCategories, #id)();
  RealColumn get unitInStock => real().withDefault(const Constant(0))();
  RealColumn get discountPercentage =>
      real().check(discountPercentage.isNotNull())();
  RealColumn get reorderLevel => real()();
  IntColumn get userId => integer().references(Users, #id)();
}

/// productUnit (unit_id, unit_name)
/// desc: unit refers to the unit of measurement that is used as a standard for measurement of the same kind of quantity
/// note each product at least one product unit
/// columns 6 :
/// id: is the primary key of the table,
/// code: or the name of the unit.
/// price: price of the unit
/// box: if the box contains multiple products
/// subTotal: box * price
/// product Id : ref to the product
@DataClassName("ProductUnit")
class ProductUnits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()();
  RealColumn get price => real()();
  RealColumn get box => real().withDefault(const Constant(1))();
  RealColumn get subTotal => real().generatedAs(price * box)();
  IntColumn get productId => integer().references(Products, #id)();
}

///productCategory (category_id, category_name)
///desc: products are grouped according to their type and the type of products will be encoded and stored in the tlb ProductCategory.
///columns 2:
/// category_id is the primary key or unique key of the table,
/// category_name or the name of the category.
@DataClassName("ProductCategory")
class ProductCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().check(name.isNotNull())();
}

///customer (customer_id, customer_code, customer_name, contact, address)
///desc: customer information will be encoded and stored in the tbl customer table,
///columns 5:
///(1) the primary key of the table is the customer_id column,
///(2) customer_code refers to the barcode that will be assigned to the customer,
///(3) customer_name is the full name of the customer,
///(4) contact is to the contact number or mobile number of the customer and,
///(5) address is to the complete address of the customer.
@DataClassName("Customer")
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().withLength(max: 25)();
  TextColumn get name => text().withLength(max: 50)();
  TextColumn get contact => text().withLength(max: 10)();
  TextColumn get address => text().withLength(max: 100)();
  TextColumn get email => text().withLength(max: 50)();
}

/// sales (sales_id, invoice_id, product_id, quantity, unit_price, sub_total)
/// desc: sales is the table where the list of items or products bought by the customers will be stored.
/// columns 6
/// (1) sales_id is the primary key of the table and it is usually the unique key which means that no duplicate value will be stored in this column,
/// (2) invoice_id is a foreign key that links to the tbl invoice table,
/// (3) product_id is also a foreign key that connects to the tbl product table,
/// (4) quantity refers to the number of items bought by the customer,
/// (5) unit_price is the price per item, and
/// (6) sub_total is equals to the number of quantity multiply by the unit price.
@DataClassName("Sale")
class Sales extends Table {
  IntColumn get salesId => integer().autoIncrement()();
  IntColumn get invoiceId => integer().check(invoiceId.isNotNull())();
  IntColumn get productId => integer().check(productId.isNotNull())();
  RealColumn get quantity => real().check(quantity.isNotNull())();
  RealColumn get unitPrice => real().check(unitPrice.isNotNull())();
  RealColumn get subTotal => real().generatedAs(quantity * unitPrice)();
}

///supplier (supplier_id, supplier_code, supplier_name, supplier_contact, supplier_address, supplier_email)
///desc:  The list of suppliers that provides the different items for the store are also being recorded
///in the system for future references and report generation and it is stored in the tbl supplier.
///columns 6:
///(1) supplier_id is the primary key and it is usually auto-generated by the database which is set to auto_increment,
///(2) supplier_code serves as the id number that the stores uses to identify each customer,
///(3) supplier_name refers to the name of the supplier,
///(4) supplier_contact is the contact information or contact number of the supplier,
///(5) supplier_address states the complete address of the supplier or company,
///(6) supplier_email stores the email address of the supplier or company.
@DataClassName("Supplier")
class Suppliers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().withLength(max: 25)();
  TextColumn get name => text().withLength(max: 50)();
  TextColumn get contact => text().withLength(max: 10)();
  TextColumn get address => text().withLength(max: 100)();
  TextColumn get email => text().withLength(max: 50)();
}

/// invoice (invoice_id, customer_id, payment_type, total_amount, amount_tendered, date_recorded, user_id)
/// desc:  An invoice is a commercial document that itemizes and records a transaction between a buyer and a seller.
/// columns 7:
/// (1) invoice_id is the primary key of the table,
/// (2) customer_id is a foreign key that links to the tbl customer table,
/// (3) payment_type refers to the payment method which is cash or credit,
/// (4) total_amount the amount that the customer needs to pay,
/// (5) amount_tendered is the payment made by the customer,
/// (6) date_recorded the date of transaction,
/// (7) user_id is a foreign key that links to the tbl user, it refers to the user who conducted the transaction.

@DataClassName("Invoice")
class Invoices extends Table {
  IntColumn get invoiceId => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customers, #id)();
  IntColumn get paymentType => intEnum<PaymentType>()();
  RealColumn get totalAmount => real().check(totalAmount.isNotNull())();
  RealColumn get amountTendered => real().check(amountTendered.isNotNull())();
  DateTimeColumn get dateRecorded =>
      dateTime().withDefault(currentDateAndTime)();
  IntColumn get userId => integer().references(Users, #id)();
}

///purchaseOrder (purchase_order_id, product_id, quantity, unit_price, sub_total, supplier_id, order_date, user_id)
///desc: the store needs to replenish its products and it needs to request or order to its supplier. The table that will hold the record of the purchase orders is the tbl purchaseOrder.
///columns 8:
///(1) purchase_order_id is the primary key of the table,
///(2) product_id is a foreign key that links to the tbl product,
///(3) quantity refers to the number of items to be order,
///(4) unit_price is the price per item of the product,
///(5) sub_total is equal to the quantity time the number of quantity,
///(6) supplier_id refers to the supplier who will provide the item,
///(7) the date of process is the order_date,
///(8) user_id is a foreign key that refers to the user who processed the purchase order.
@DataClassName("PurchaseOrder")
class PurchaseOrders extends Table {
  IntColumn get purchaseOrderId => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  RealColumn get quantity => real().check(quantity.isNotNull())();
  RealColumn get unitPrice => real().check(unitPrice.isNotNull())();
  RealColumn get subTotal => real().generatedAs(quantity * unitPrice)();
  IntColumn get supplierId => integer().references(Suppliers, #id)();
  DateTimeColumn get orderDate => dateTime().withDefault(currentDateAndTime)();
  IntColumn get userId => integer().references(Users, #id)();
}

/// receiveProduct (receive_product_id, product_id, quantity, unit_price, sub_total, supplier_id, received_date, user_id)
/// desc:  after the purchase order, the store will wait for the supplier to deliver the products, once delivered the information will be encoded and stored in the tbl receiveProduct.
/// columns 8:
///  (1) receive_product_id is the primary key of the table,
/// (2) product_id is a foreign key that links to the tbl product,
/// (3) quantity refers to the number of items to be order,
/// (4) unit_price is the price per item of the product,
/// (5) sub_total is equal to the quantity time the number of quantity,
/// (6) supplier_id refers to the supplier who will provide the item,
/// (7) received_date refers to the delivery date,
/// (8) user_id is a foreign key that refers to the user who received the delivery.
@DataClassName("ReceiveProduct")
class ReceiveProducts extends Table {
  IntColumn get receiveProductId => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  RealColumn get quantity => real().check(quantity.isNotNull())();
  RealColumn get unitPrice => real().check(unitPrice.isNotNull())();
  RealColumn get subTotal => real().generatedAs(quantity * unitPrice)();
  IntColumn get supplierId => integer().references(Suppliers, #id)();
  DateTimeColumn get receivedDate =>
      dateTime().withDefault(currentDateAndTime)();
  IntColumn get userId => integer().references(Users, #id)();
}

///debt (id,amount ,accountID,date_recorded,user_id)
///desc: the debts of the user with suppliers and customers
///note:
///the user can create default accounts like repaire gas ... account to manage money
///if the amount is positive means that we give money
///else we get
///columns 5:
///(1):the primary key
///(2):amount
///(3):account_id is the customer or the supplier id
///(4):isCustomer :bool check if this debt is for customer
///(5):date recorded
///(6): userId
@DataClassName("Debt")
class Debts extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get amount => real()();
  IntColumn get customerId => integer().references(Customers, #id)();
  IntColumn get supplierId => integer().references(Suppliers, #id)();
  DateTimeColumn get dateRecorded =>
      dateTime().withDefault(currentDateAndTime)();
  IntColumn get userId => integer().references(Users, #id)();
}
