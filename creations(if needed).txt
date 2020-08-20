-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema DBProject
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DBProject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DBProject` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `DBProject` ;

-- -----------------------------------------------------
-- Table `DBProject`.`Player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBProject`.`Player` ;

CREATE TABLE IF NOT EXISTS `DBProject`.`Player` (
  `PlayerID` VARCHAR(45) NOT NULL,
  `PlayerName` VARCHAR(45) NULL,
  PRIMARY KEY (`PlayerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBProject`.`Server`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBProject`.`Server` ;

CREATE TABLE IF NOT EXISTS `DBProject`.`Server` (
  `ServerName` VARCHAR(45) NOT NULL,
  `Region` VARCHAR(45) NULL,
  `ServerStatus` VARCHAR(45) NULL,
  `MaxPlayers` INT NULL,
  PRIMARY KEY (`ServerName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBProject`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBProject`.`Account` ;

CREATE TABLE IF NOT EXISTS `DBProject`.`Account` (
  `Email` VARCHAR(45) NOT NULL,
  `Password` INT NULL,
  `UserName` VARCHAR(45) NULL,
  `LastSignedIn` DATE NULL,
  `CreatedIn` DATE NULL,
  `PlayerID` VARCHAR(45) NOT NULL,
  `ServerName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Email`, `PlayerID`, `ServerName`),
  UNIQUE INDEX `UserName_UNIQUE` (`UserName` ASC),
  INDEX `fk_Account_Player_idx` (`PlayerID` ASC),
  INDEX `fk_Account_Server1_idx` (`ServerName` ASC),
  CONSTRAINT `fk_Account_Player`
    FOREIGN KEY (`PlayerID`)
    REFERENCES `DBProject`.`Player` (`PlayerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Account_Server1`
    FOREIGN KEY (`ServerName`)
    REFERENCES `DBProject`.`Server` (`ServerName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBProject`.`Character`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBProject`.`Character` ;

CREATE TABLE IF NOT EXISTS `DBProject`.`Character` (
  `CharName` VARCHAR(45) NOT NULL,
  `Gender` VARCHAR(45) NULL,
  `Type` VARCHAR(45) NULL,
  `MaxHP` INT NULL,
  `MaxMana` INT NULL,
  `XP` INT NULL,
  `Level` INT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CharName`, `Email`),
  INDEX `fk_Character_Account1_idx` (`Email` ASC),
  CONSTRAINT `fk_Character_Account1`
    FOREIGN KEY (`Email`)
    REFERENCES `DBProject`.`Account` (`Email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBProject`.`ItemSet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBProject`.`ItemSet` ;

CREATE TABLE IF NOT EXISTS `DBProject`.`ItemSet` (
  `SetID` VARCHAR(45) NOT NULL,
  `MaxCap` INT NULL,
  `TotalDmg` INT NULL,
  `TotalDef` INT NULL,
  `CharName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SetID`, `CharName`),
  INDEX `fk_ItemSet_Character1_idx` (`CharName` ASC),
  CONSTRAINT `fk_ItemSet_Character1`
    FOREIGN KEY (`CharName`)
    REFERENCES `DBProject`.`Character` (`CharName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBProject`.`ItemShop`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBProject`.`ItemShop` ;

CREATE TABLE IF NOT EXISTS `DBProject`.`ItemShop` (
  `Type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBProject`.`Minion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBProject`.`Minion` ;

CREATE TABLE IF NOT EXISTS `DBProject`.`Minion` (
  `Name` VARCHAR(45) NOT NULL,
  `Type` VARCHAR(45) NULL,
  `Damage` INT NULL,
  `Health` INT NULL,
  `CoinDrop` INT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBProject`.`Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBProject`.`Item` ;

CREATE TABLE IF NOT EXISTS `DBProject`.`Item` (
  `ItemName` VARCHAR(45) NOT NULL,
  `Capacity` INT NULL,
  `Cost` INT NULL,
  `SetID` VARCHAR(45) NOT NULL,
  `ItemType` VARCHAR(45) NOT NULL,
  `Minion_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ItemName`, `ItemType`, `Minion_Name`),
  INDEX `fk_Item_ItemSet1_idx` (`SetID` ASC),
  INDEX `fk_Item_ItemShop1_idx` (`ItemType` ASC),
  INDEX `fk_Item_Minion1_idx` (`Minion_Name` ASC),
  CONSTRAINT `fk_Item_ItemSet1`
    FOREIGN KEY (`SetID`)
    REFERENCES `DBProject`.`ItemSet` (`SetID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_ItemShop1`
    FOREIGN KEY (`ItemType`)
    REFERENCES `DBProject`.`ItemShop` (`Type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_Minion1`
    FOREIGN KEY (`Minion_Name`)
    REFERENCES `DBProject`.`Minion` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBProject`.`DmgItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBProject`.`DmgItems` ;

CREATE TABLE IF NOT EXISTS `DBProject`.`DmgItems` (
  `ItemName` VARCHAR(45) NOT NULL,
  `Capacity` INT NULL,
  `Cost` INT NULL,
  `Damage` INT NOT NULL,
  INDEX `fk_DmgItems_Item1_idx` (`ItemName` ASC),
  PRIMARY KEY (`ItemName`),
  CONSTRAINT `fk_DmgItems_Item1`
    FOREIGN KEY (`ItemName`)
    REFERENCES `DBProject`.`Item` (`ItemName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBProject`.`DefItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBProject`.`DefItems` ;

CREATE TABLE IF NOT EXISTS `DBProject`.`DefItems` (
  `ItemName` VARCHAR(45) NOT NULL,
  `Capacity` INT NOT NULL,
  `Cost` INT NULL,
  `Defense` VARCHAR(45) NULL,
  INDEX `fk_DefItems_Item1_idx` (`ItemName` ASC),
  PRIMARY KEY (`ItemName`),
  CONSTRAINT `fk_DefItems_Item1`
    FOREIGN KEY (`ItemName`)
    REFERENCES `DBProject`.`Item` (`ItemName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBProject`.`Outfit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DBProject`.`Outfit` ;

CREATE TABLE IF NOT EXISTS `DBProject`.`Outfit` (
  `ItemName` VARCHAR(45) NOT NULL,
  `Capacity` INT NOT NULL,
  `Cost` INT NULL,
  INDEX `fk_Outfit_Item1_idx` (`ItemName` ASC),
  PRIMARY KEY (`ItemName`),
  CONSTRAINT `fk_Outfit_Item1`
    FOREIGN KEY (`ItemName`)
    REFERENCES `DBProject`.`Item` (`ItemName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `DBProject`.`Player`
-- -----------------------------------------------------
START TRANSACTION;
USE `DBProject`;
INSERT INTO `DBProject`.`Player` (`PlayerID`, `PlayerName`) VALUES ('H1', 'Harry');
INSERT INTO `DBProject`.`Player` (`PlayerID`, `PlayerName`) VALUES ('J2', 'Jack');
INSERT INTO `DBProject`.`Player` (`PlayerID`, `PlayerName`) VALUES ('J3', 'Jacob');
INSERT INTO `DBProject`.`Player` (`PlayerID`, `PlayerName`) VALUES ('H4', 'Henry');
INSERT INTO `DBProject`.`Player` (`PlayerID`, `PlayerName`) VALUES ('L5', 'Lucas');
INSERT INTO `DBProject`.`Player` (`PlayerID`, `PlayerName`) VALUES ('O6', 'Oscar');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DBProject`.`Server`
-- -----------------------------------------------------
START TRANSACTION;
USE `DBProject`;
INSERT INTO `DBProject`.`Server` (`ServerName`, `Region`, `ServerStatus`, `MaxPlayers`) VALUES ('EUNordicEast', 'Europe', 'Online', 2000);
INSERT INTO `DBProject`.`Server` (`ServerName`, `Region`, `ServerStatus`, `MaxPlayers`) VALUES ('EUWest', 'Europe', 'Offline', 3000);
INSERT INTO `DBProject`.`Server` (`ServerName`, `Region`, `ServerStatus`, `MaxPlayers`) VALUES ('NorthAmerica', 'America', 'Online', 2000);
INSERT INTO `DBProject`.`Server` (`ServerName`, `Region`, `ServerStatus`, `MaxPlayers`) VALUES ('NorthAfrica', 'Africa', 'Maintenance', 4000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DBProject`.`Account`
-- -----------------------------------------------------
START TRANSACTION;
USE `DBProject`;
INSERT INTO `DBProject`.`Account` (`Email`, `Password`, `UserName`, `LastSignedIn`, `CreatedIn`, `PlayerID`, `ServerName`) VALUES ('Harry@yahoo.com', 1324865, 'Harry201', '2018-11-12', '2018-02-12', 'H1', 'EUNordicEast');
INSERT INTO `DBProject`.`Account` (`Email`, `Password`, `UserName`, `LastSignedIn`, `CreatedIn`, `PlayerID`, `ServerName`) VALUES ('Jack@yahoo.com', 5324867, 'Jack0124', '2018-12-05', '2018-01-13', 'J2', 'EUNoridcEast');
INSERT INTO `DBProject`.`Account` (`Email`, `Password`, `UserName`, `LastSignedIn`, `CreatedIn`, `PlayerID`, `ServerName`) VALUES ('Jacob@gmail.com', 6219756, 'Jacob547', '2018-10-10', '2018-03-14', 'J3', 'EUWest');
INSERT INTO `DBProject`.`Account` (`Email`, `Password`, `UserName`, `LastSignedIn`, `CreatedIn`, `PlayerID`, `ServerName`) VALUES ('Luca@gmail.com', 3164975, 'Lucas001', '2018-12-10', '2018-04-13', 'L4', 'NorthAmerica');
INSERT INTO `DBProject`.`Account` (`Email`, `Password`, `UserName`, `LastSignedIn`, `CreatedIn`, `PlayerID`, `ServerName`) VALUES ('Oscar@gmail.com', 4516895, 'Oscar25', '2012-08-16', '2018-01-25', 'O5', 'NorthAfrica');
INSERT INTO `DBProject`.`Account` (`Email`, `Password`, `UserName`, `LastSignedIn`, `CreatedIn`, `PlayerID`, `ServerName`) VALUES ('Henry@gmail.com', 3254196, 'Henry12', '2018-12-12', '2018-02-22', 'H6', 'NorthAfrica');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DBProject`.`Character`
-- -----------------------------------------------------
START TRANSACTION;
USE `DBProject`;
INSERT INTO `DBProject`.`Character` (`CharName`, `Gender`, `Type`, `MaxHP`, `MaxMana`, `XP`, `Level`, `Email`) VALUES ('Yasuo', 'Male', 'Assassin', 30000, 15000, 250000, 30, 'Harry@yahoo.com');
INSERT INTO `DBProject`.`Character` (`CharName`, `Gender`, `Type`, `MaxHP`, `MaxMana`, `XP`, `Level`, `Email`) VALUES ('Ashe', 'Female', 'Ranged', 25000, 10000, 200000, 25, 'Jack@yahoo.com');
INSERT INTO `DBProject`.`Character` (`CharName`, `Gender`, `Type`, `MaxHP`, `MaxMana`, `XP`, `Level`, `Email`) VALUES ('Jayce', 'Male', 'Fighter', 30000, 15000, 250000, 30, 'Jacob@yahoo.com');
INSERT INTO `DBProject`.`Character` (`CharName`, `Gender`, `Type`, `MaxHP`, `MaxMana`, `XP`, `Level`, `Email`) VALUES ('Jax', 'Male', 'Tank', 20000, 75000, 150000, 20, 'Luca@gmail.com');
INSERT INTO `DBProject`.`Character` (`CharName`, `Gender`, `Type`, `MaxHP`, `MaxMana`, `XP`, `Level`, `Email`) VALUES ('Caitlyn', 'Female', 'Ranged', 30000, 15000, 250000, 30, 'Oscar@gmail.com');
INSERT INTO `DBProject`.`Character` (`CharName`, `Gender`, `Type`, `MaxHP`, `MaxMana`, `XP`, `Level`, `Email`) VALUES ('Rakan', 'Male', 'Support', 30000, 15000, 250000, 30, 'Henry@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DBProject`.`ItemSet`
-- -----------------------------------------------------
START TRANSACTION;
USE `DBProject`;
INSERT INTO `DBProject`.`ItemSet` (`SetID`, `MaxCap`, `TotalDmg`, `TotalDef`, `CharName`) VALUES ('AA5', 50, 900, 700, 'Yasuo');
INSERT INTO `DBProject`.`ItemSet` (`SetID`, `MaxCap`, `TotalDmg`, `TotalDef`, `CharName`) VALUES ('SS1', 60, 700, 600, 'Ashe');
INSERT INTO `DBProject`.`ItemSet` (`SetID`, `MaxCap`, `TotalDmg`, `TotalDef`, `CharName`) VALUES ('D33', 45, 500, 650, 'Jayce');
INSERT INTO `DBProject`.`ItemSet` (`SetID`, `MaxCap`, `TotalDmg`, `TotalDef`, `CharName`) VALUES ('D77', 30, 500, 1435, 'Jax');
INSERT INTO `DBProject`.`ItemSet` (`SetID`, `MaxCap`, `TotalDmg`, `TotalDef`, `CharName`) VALUES ('W55', 60, 700, 600, 'Caitlyn');
INSERT INTO `DBProject`.`ItemSet` (`SetID`, `MaxCap`, `TotalDmg`, `TotalDef`, `CharName`) VALUES ('Q77', 85, 500, 1000, 'Rakan');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DBProject`.`ItemShop`
-- -----------------------------------------------------
START TRANSACTION;
USE `DBProject`;
INSERT INTO `DBProject`.`ItemShop` (`Type`) VALUES ('Weapon');
INSERT INTO `DBProject`.`ItemShop` (`Type`) VALUES ('Shield');
INSERT INTO `DBProject`.`ItemShop` (`Type`) VALUES ('Outfit');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DBProject`.`Minion`
-- -----------------------------------------------------
START TRANSACTION;
USE `DBProject`;
INSERT INTO `DBProject`.`Minion` (`Name`, `Type`, `Damage`, `Health`, `CoinDrop`) VALUES ('Muji', 'General', 20, 2000, 5000);
INSERT INTO `DBProject`.`Minion` (`Name`, `Type`, `Damage`, `Health`, `CoinDrop`) VALUES ('Penon', 'Champion', 70, 4000, 7000);
INSERT INTO `DBProject`.`Minion` (`Name`, `Type`, `Damage`, `Health`, `CoinDrop`) VALUES ('Tiger', 'General', 25, 2000, 4500);
INSERT INTO `DBProject`.`Minion` (`Name`, `Type`, `Damage`, `Health`, `CoinDrop`) VALUES ('Annie', 'Champion', 30, 4350, 7500);
INSERT INTO `DBProject`.`Minion` (`Name`, `Type`, `Damage`, `Health`, `CoinDrop`) VALUES ('Syndra', 'Giant', 100, 6000, 12000);
INSERT INTO `DBProject`.`Minion` (`Name`, `Type`, `Damage`, `Health`, `CoinDrop`) VALUES ('Demon', 'General', 45, 2500, 3000);
INSERT INTO `DBProject`.`Minion` (`Name`, `Type`, `Damage`, `Health`, `CoinDrop`) VALUES ('Ong', 'Giant', 130, 6500, 11000);
INSERT INTO `DBProject`.`Minion` (`Name`, `Type`, `Damage`, `Health`, `CoinDrop`) VALUES ('Spider', 'General', 30, 2100, 5500);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DBProject`.`Item`
-- -----------------------------------------------------
START TRANSACTION;
USE `DBProject`;
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Spear', 20, 200000, 'AA5', 'Weapon', 'Muji');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Sword', 25, 300000, 'Q77', 'Weapon', 'Tiger');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Blade', 15, 250000, 'AA5', 'Weapon', 'Annie');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Bow', 30, 150000, 'W55', 'Weapon', 'Penon');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Helmet', 10, 55000, 'SS1', 'Shield', 'Spider');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Helmet2', 15, 60000, 'AA5', 'Shield', 'Syndra');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Helmet3', 20, 100000, 'Q77', 'Shield', 'Muji');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Vest', 5, 55000, 'Q77', 'Shield', 'Tiger');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Vest2', 10, 60000, 'SS1', 'Shield', 'Demon');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Vest3', 15, 100000, 'W55', 'Shield', 'Muji');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Legs', 5, 55000, 'Q77', 'Shield', 'Ong');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Legs2', 10, 60000, 'AA5', 'Shield', 'Penon');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Legs3', 15, 100000, 'SS1', 'Shield', 'Annie');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Boot', 5, 55000, 'W55', 'Shield', 'Demon');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Boot2', 10, 60000, 'SS1', 'Shield', 'Ong');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('Boot3', 15, 100000, 'D77', 'Shield', 'Syndra');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('RedOutfit', 10, 25000, 'Q77', 'Outfit', 'Muji');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('BlueOutfit', 10, 25000, 'AA5', 'Outfit', 'Penon');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('WhiteOutfit', 10, 25000, 'D77', 'Outfit', 'Tiger');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('BlackOutfit', 10, 25000, 'W55', 'Outfit', 'Annie');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('GreenOutfit', 10, 25000, 'AA5', 'Outfit', 'Syndra');
INSERT INTO `DBProject`.`Item` (`ItemName`, `Capacity`, `Cost`, `SetID`, `ItemType`, `Minion_Name`) VALUES ('YellowOutfit', 10, 25000, 'D77', 'Outfit', 'Demon');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DBProject`.`DmgItems`
-- -----------------------------------------------------
START TRANSACTION;
USE `DBProject`;
INSERT INTO `DBProject`.`DmgItems` (`ItemName`, `Capacity`, `Cost`, `Damage`) VALUES ('Spear', 20, 200000, 500);
INSERT INTO `DBProject`.`DmgItems` (`ItemName`, `Capacity`, `Cost`, `Damage`) VALUES ('Sword', 25, 300000, 900);
INSERT INTO `DBProject`.`DmgItems` (`ItemName`, `Capacity`, `Cost`, `Damage`) VALUES ('Blade', 15, 250000, 500);
INSERT INTO `DBProject`.`DmgItems` (`ItemName`, `Capacity`, `Cost`, `Damage`) VALUES ('Bow', 30, 150000, 700);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DBProject`.`DefItems`
-- -----------------------------------------------------
START TRANSACTION;
USE `DBProject`;
INSERT INTO `DBProject`.`DefItems` (`ItemName`, `Capacity`, `Cost`, `Defense`) VALUES ('Helmet', 10, 55000, '100');
INSERT INTO `DBProject`.`DefItems` (`ItemName`, `Capacity`, `Cost`, `Defense`) VALUES ('Helmet2', 15, 60000, '250');
INSERT INTO `DBProject`.`DefItems` (`ItemName`, `Capacity`, `Cost`, `Defense`) VALUES ('Helmet3', 20, 100000, '350');
INSERT INTO `DBProject`.`DefItems` (`ItemName`, `Capacity`, `Cost`, `Defense`) VALUES ('Vest', 5, 55000, '105');
INSERT INTO `DBProject`.`DefItems` (`ItemName`, `Capacity`, `Cost`, `Defense`) VALUES ('Vest2', 10, 60000, '270');
INSERT INTO `DBProject`.`DefItems` (`ItemName`, `Capacity`, `Cost`, `Defense`) VALUES ('Vest3', 15, 100000, '385');
INSERT INTO `DBProject`.`DefItems` (`ItemName`, `Capacity`, `Cost`, `Defense`) VALUES ('Legs', 5, 55000, '110');
INSERT INTO `DBProject`.`DefItems` (`ItemName`, `Capacity`, `Cost`, `Defense`) VALUES ('Legs2', 10, 60000, '260');
INSERT INTO `DBProject`.`DefItems` (`ItemName`, `Capacity`, `Cost`, `Defense`) VALUES ('Legs3', 15, 100000, '375');
INSERT INTO `DBProject`.`DefItems` (`ItemName`, `Capacity`, `Cost`, `Defense`) VALUES ('Boot', 5, 55000, '70');
INSERT INTO `DBProject`.`DefItems` (`ItemName`, `Capacity`, `Cost`, `Defense`) VALUES ('Boot2', 10, 60000, '250');
INSERT INTO `DBProject`.`DefItems` (`ItemName`, `Capacity`, `Cost`, `Defense`) VALUES ('Boot3', 15, 100000, '325');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DBProject`.`Outfit`
-- -----------------------------------------------------
START TRANSACTION;
USE `DBProject`;
INSERT INTO `DBProject`.`Outfit` (`ItemName`, `Capacity`, `Cost`) VALUES ('RedOutfit', 10, 25000);
INSERT INTO `DBProject`.`Outfit` (`ItemName`, `Capacity`, `Cost`) VALUES ('BlueOutfit', 10, 25000);
INSERT INTO `DBProject`.`Outfit` (`ItemName`, `Capacity`, `Cost`) VALUES ('WhiteOutfit', 10, 25000);
INSERT INTO `DBProject`.`Outfit` (`ItemName`, `Capacity`, `Cost`) VALUES ('BlackOutfit', 10, 25000);
INSERT INTO `DBProject`.`Outfit` (`ItemName`, `Capacity`, `Cost`) VALUES ('GreenOutfit', 10, 25000);
INSERT INTO `DBProject`.`Outfit` (`ItemName`, `Capacity`, `Cost`) VALUES ('YellowOutfit', 10, 25000);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
