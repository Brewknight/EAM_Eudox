-- MySQL Script generated by MySQL Workbench
-- Σαβ 29 Δεκ 2018 04:26:23 μμ EET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User` ;

CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `Username` VARCHAR(25) NOT NULL,
  `Email` VARCHAR(320) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Type` ENUM('Student', 'Publisher', 'Secretary', 'Distributor', 'PublDist') NOT NULL,
  `Last_Login` DATETIME NOT NULL,
  PRIMARY KEY (`Username`, `Email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Address` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Address` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `City` VARCHAR(45) NOT NULL,
  `ZipCode` INT NOT NULL,
  `Street_Name` VARCHAR(45) NOT NULL,
  `Street_Number` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Publisher` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Publisher` (
  `Username` VARCHAR(25) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(10) NOT NULL,
  `Address_Id` INT NOT NULL,
  INDEX `fk_Publisher_Users1_idx` (`Username` ASC) VISIBLE,
  PRIMARY KEY (`Username`),
  INDEX `fk_Publisher_Address1_idx` (`Address_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Publisher_Users1`
    FOREIGN KEY (`Username`)
    REFERENCES `mydb`.`User` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Publisher_Address1`
    FOREIGN KEY (`Address_Id`)
    REFERENCES `mydb`.`Address` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Textbook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Textbook` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Textbook` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Publisher_Username` VARCHAR(25) NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Writer` VARCHAR(255) NOT NULL,
  `Date_Published` DATE NOT NULL,
  `Last_Edited` DATETIME NOT NULL,
  `Date_Added` DATE NOT NULL,
  `Price` FLOAT NOT NULL,
  `ISBN` CHAR(10) NOT NULL,
  `Issue_Number` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Textbook_Publisher1_idx` (`Publisher_Username` ASC) VISIBLE,
  CONSTRAINT `fk_Textbook_Publisher1`
    FOREIGN KEY (`Publisher_Username`)
    REFERENCES `mydb`.`Publisher` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`University`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`University` ;

CREATE TABLE IF NOT EXISTS `mydb`.`University` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`University_Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`University_Department` ;

CREATE TABLE IF NOT EXISTS `mydb`.`University_Department` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `University_Id` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_University_Department_University1_idx` (`University_Id` ASC) VISIBLE,
  CONSTRAINT `fk_University_Department_University1`
    FOREIGN KEY (`University_Id`)
    REFERENCES `mydb`.`University` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Course` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Course` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `University_Department_Id` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Semester` INT NOT NULL,
  `Professor_Name` VARCHAR(255) NULL,
  `Professor_Surname` VARCHAR(255) NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Course_University_Department1_idx` (`University_Department_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Course_University_Department1`
    FOREIGN KEY (`University_Department_Id`)
    REFERENCES `mydb`.`University_Department` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Student` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Student` (
  `Username` VARCHAR(25) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(10) NOT NULL,
  `Student_Id` VARCHAR(12) NOT NULL,
  `Personal_Id` VARCHAR(8) NOT NULL,
  `University_Department_Id` INT NOT NULL,
  INDEX `fk_Student_Users_idx` (`Username` ASC) VISIBLE,
  PRIMARY KEY (`Username`),
  INDEX `fk_Student_University_Department1_idx` (`University_Department_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Users`
    FOREIGN KEY (`Username`)
    REFERENCES `mydb`.`User` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_University_Department1`
    FOREIGN KEY (`University_Department_Id`)
    REFERENCES `mydb`.`University_Department` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Secretary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Secretary` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Secretary` (
  `Username` VARCHAR(25) NOT NULL,
  `University_Department_Id` INT NOT NULL,
  INDEX `fk_Secretary_Users1_idx` (`Username` ASC) VISIBLE,
  PRIMARY KEY (`Username`),
  CONSTRAINT `fk_Secretary_Users1`
    FOREIGN KEY (`Username`)
    REFERENCES `mydb`.`User` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Secretary_University_Department1`
    FOREIGN KEY (`University_Department_Id`)
    REFERENCES `mydb`.`University_Department` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Distribution_Point`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Distribution_Point` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Distribution_Point` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Owner` VARCHAR(25) NOT NULL,
  `Address_Id` INT NOT NULL,
  `Phone` VARCHAR(10) NULL,
  `Working_Hours` TEXT NULL,
  `Name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Distribution_Point_Address1_idx` (`Address_Id` ASC) VISIBLE,
  INDEX `fk_Distribution_Point_User1_idx` (`Owner` ASC) VISIBLE,
  CONSTRAINT `fk_Distribution_Point_Address1`
    FOREIGN KEY (`Address_Id`)
    REFERENCES `mydb`.`Address` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Distribution_Point_User1`
    FOREIGN KEY (`Owner`)
    REFERENCES `mydb`.`User` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Course_has_Textbook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Course_has_Textbook` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Course_has_Textbook` (
  `Course_Id` INT NOT NULL,
  `Textbook_Id` INT NOT NULL,
  PRIMARY KEY (`Course_Id`, `Textbook_Id`),
  INDEX `fk_Course_has_Textbook_Textbook1_idx` (`Textbook_Id` ASC) VISIBLE,
  INDEX `fk_Course_has_Textbook_Course1_idx` (`Course_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Course_has_Textbook_Course1`
    FOREIGN KEY (`Course_Id`)
    REFERENCES `mydb`.`Course` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Course_has_Textbook_Textbook1`
    FOREIGN KEY (`Textbook_Id`)
    REFERENCES `mydb`.`Textbook` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Textbook_Application`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Textbook_Application` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Textbook_Application` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Date` DATETIME NOT NULL,
  `Is_Current` TINYINT NOT NULL,
  `PIN` VARCHAR(16) NULL,
  `Status` ENUM('Pending', 'Completed') NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student_has_Textbook_Application`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Student_has_Textbook_Application` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Student_has_Textbook_Application` (
  `Textbook_Application_Id` INT NOT NULL,
  `Student_Username` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Textbook_Application_Id`, `Student_Username`),
  INDEX `fk_Textbook_Application_has_Student_Student1_idx` (`Student_Username` ASC) VISIBLE,
  INDEX `fk_Textbook_Application_has_Student_Textbook_Application1_idx` (`Textbook_Application_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Textbook_Application_has_Student_Textbook_Application1`
    FOREIGN KEY (`Textbook_Application_Id`)
    REFERENCES `mydb`.`Textbook_Application` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Textbook_Application_has_Student_Student1`
    FOREIGN KEY (`Student_Username`)
    REFERENCES `mydb`.`Student` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Textbook_Application_has_Textbook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Textbook_Application_has_Textbook` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Textbook_Application_has_Textbook` (
  `Textbook_Application_Id` INT NOT NULL,
  `Textbook_Id` INT NOT NULL,
  PRIMARY KEY (`Textbook_Application_Id`, `Textbook_Id`),
  INDEX `fk_Textbook_Application_has_Textbook_Textbook1_idx` (`Textbook_Id` ASC) VISIBLE,
  INDEX `fk_Textbook_Application_has_Textbook_Textbook_Application1_idx` (`Textbook_Application_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Textbook_Application_has_Textbook_Textbook_Application1`
    FOREIGN KEY (`Textbook_Application_Id`)
    REFERENCES `mydb`.`Textbook_Application` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Textbook_Application_has_Textbook_Textbook1`
    FOREIGN KEY (`Textbook_Id`)
    REFERENCES `mydb`.`Textbook` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Distribution_Point_has_Textbook`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Distribution_Point_has_Textbook` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Distribution_Point_has_Textbook` (
  `Distribution_Point_Id` INT NOT NULL,
  `Textbook_Id` INT NOT NULL,
  PRIMARY KEY (`Distribution_Point_Id`, `Textbook_Id`),
  INDEX `fk_Distribution_Point_has_Textbook_Textbook1_idx` (`Textbook_Id` ASC) VISIBLE,
  INDEX `fk_Distribution_Point_has_Textbook_Distribution_Point1_idx` (`Distribution_Point_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Distribution_Point_has_Textbook_Distribution_Point1`
    FOREIGN KEY (`Distribution_Point_Id`)
    REFERENCES `mydb`.`Distribution_Point` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Distribution_Point_has_Textbook_Textbook1`
    FOREIGN KEY (`Textbook_Id`)
    REFERENCES `mydb`.`Textbook` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order_Request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Order_Request` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Order_Request` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Publ_Username` VARCHAR(25) NOT NULL,
  `Distribution_Point_Id` INT NOT NULL,
  `Textbook_Id` INT NOT NULL,
  `Status` ENUM('Accepted', 'Declined', 'Pending') NOT NULL,
  `Date_Issued` DATETIME NOT NULL,
  `Date_Completed` DATETIME NULL,
  `Copies` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Dist_Request_Publisher1_idx` (`Publ_Username` ASC) VISIBLE,
  INDEX `fk_Dist_Request_Distribution_Point1_idx` (`Distribution_Point_Id` ASC) VISIBLE,
  INDEX `fk_Dist_Request_Textbook1_idx` (`Textbook_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Dist_Request_Publisher1`
    FOREIGN KEY (`Publ_Username`)
    REFERENCES `mydb`.`Publisher` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dist_Request_Distribution_Point1`
    FOREIGN KEY (`Distribution_Point_Id`)
    REFERENCES `mydb`.`Distribution_Point` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dist_Request_Textbook1`
    FOREIGN KEY (`Textbook_Id`)
    REFERENCES `mydb`.`Textbook` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dist_Request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Dist_Request` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Dist_Request` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Publ_Username` VARCHAR(25) NOT NULL,
  `Distribution_Point_Id` INT NOT NULL,
  `Textbook_Id` INT NOT NULL,
  `Status` ENUM('Accepted', 'Declined', 'Pending') NOT NULL,
  `Date_Issued` DATETIME NOT NULL,
  `Date_Completed` DATETIME NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Dist_Request_Publisher1_idx` (`Publ_Username` ASC) VISIBLE,
  INDEX `fk_Dist_Request_Distribution_Point1_idx` (`Distribution_Point_Id` ASC) VISIBLE,
  INDEX `fk_Dist_Request_Textbook1_idx` (`Textbook_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Dist_Request_Publisher10`
    FOREIGN KEY (`Publ_Username`)
    REFERENCES `mydb`.`Publisher` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dist_Request_Distribution_Point10`
    FOREIGN KEY (`Distribution_Point_Id`)
    REFERENCES `mydb`.`Distribution_Point` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dist_Request_Textbook10`
    FOREIGN KEY (`Textbook_Id`)
    REFERENCES `mydb`.`Textbook` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Keyword` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Keyword` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Word` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Textbook_has_Keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Textbook_has_Keyword` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Textbook_has_Keyword` (
  `Textbook_Id` INT NOT NULL,
  `Keyword_Id` INT NOT NULL,
  PRIMARY KEY (`Textbook_Id`, `Keyword_Id`),
  INDEX `fk_Textbook_has_Keyword_Keyword1_idx` (`Keyword_Id` ASC) VISIBLE,
  INDEX `fk_Textbook_has_Keyword_Textbook1_idx` (`Textbook_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Textbook_has_Keyword_Textbook1`
    FOREIGN KEY (`Textbook_Id`)
    REFERENCES `mydb`.`Textbook` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Textbook_has_Keyword_Keyword1`
    FOREIGN KEY (`Keyword_Id`)
    REFERENCES `mydb`.`Keyword` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
