USE lab_mysql;

CREATE TABLE IF NOT EXISTS `lab_mysql`.`Customers` (
  `id` INT NULL AUTO_INCREMENT,
  `idCustomer` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `adress` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `zip_code` VARCHAR(45) NULL,
  UNIQUE INDEX `idCar_UNIQUE` (`id` ASC),
  PRIMARY KEY (`idCustomer`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `lab_mysql`.`Cars` (
  `id` INT NULL AUTO_INCREMENT,
  `idCar` VARCHAR(45) NOT NULL,
  `manufacturer` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  `year` INT NULL,
  `color` VARCHAR(45) NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  PRIMARY KEY (`idCar`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `lab_mysql`.`SalesPerson` (
  `id` INT NULL AUTO_INCREMENT,
  `SalesPersoncol` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `store` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  PRIMARY KEY (`SalesPersoncol`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `lab_mysql`.`Invoices` (
  `id` INT NULL AUTO_INCREMENT,
  `idInvoice` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `car` VARCHAR(45) NOT NULL,
  `customer` VARCHAR(45) NOT NULL,
  `salesperson` VARCHAR(45) NOT NULL,
  `Customers_idCustomer` VARCHAR(45) NOT NULL,
  `SalesPerson_SalesPersoncol` VARCHAR(45) NOT NULL,
  `Cars_idCar` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idInvoice`, `Customers_idCustomer`, `SalesPerson_SalesPersoncol`, `Cars_idCar`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_Invoices_Customers_idx` (`Customers_idCustomer` ASC),
  INDEX `fk_Invoices_SalesPerson1_idx` (`SalesPerson_SalesPersoncol` ASC),
  INDEX `fk_Invoices_Cars1_idx` (`Cars_idCar` ASC),
  CONSTRAINT `fk_Invoices_Customers`
    FOREIGN KEY (`Customers_idCustomer`)
    REFERENCES `lab_mysql`.`Customers` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invoices_SalesPerson1`
    FOREIGN KEY (`SalesPerson_SalesPersoncol`)
    REFERENCES `lab_mysql`.`SalesPerson` (`SalesPersoncol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invoices_Cars1`
    FOREIGN KEY (`Cars_idCar`)
    REFERENCES `lab_mysql`.`Cars` (`idCar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

