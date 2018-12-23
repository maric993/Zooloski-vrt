-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema zooPBP
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema zooPBP
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zooPBP` DEFAULT CHARACTER SET utf8 ;
USE `zooPBP` ;

-- -----------------------------------------------------
-- Table `zooPBP`.`Dobavljac`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zooPBP`.`Dobavljac` (
  `id_dobavljaca` INT(11) NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(45) NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_dobavljaca`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zooPBP`.`Kavez`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zooPBP`.`Kavez` (
  `id_kaveza` INT(11) NOT NULL AUTO_INCREMENT,
  `tip_stanista` VARCHAR(45) NOT NULL,
  `kapacitet` INT(11) NOT NULL,
  `datum_poslednjeg_ciscenja` DATE NOT NULL,
  PRIMARY KEY (`id_kaveza`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zooPBP`.`Vrsta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zooPBP`.`Vrsta` (
  `id_vrste` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NOT NULL,
  `interval_ishrane` INT NOT NULL,
  `opis` VARCHAR(200) NOT NULL,
  `broj_stanara` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_vrste`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zooPBP`.`Zivotinja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zooPBP`.`Zivotinja` (
  `id_zivotinje` INT(11) NOT NULL AUTO_INCREMENT,
  `id_vrste` INT NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `naziv_vrste` VARCHAR(45) NOT NULL,
  `datum_rodjenja` DATE NOT NULL,
  `pol` VARCHAR(1) NOT NULL,
  `interval_ishrane` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `datum_useljenja` DATE NOT NULL,
  `datum_iseljenja` DATE NULL,
  PRIMARY KEY (`id_zivotinje`),
  INDEX `fk_Zivotinja_Vrsta1_idx` (`id_vrste` ASC),
  CONSTRAINT `fk_Zivotinja_Vrsta1`
    FOREIGN KEY (`id_vrste`)
    REFERENCES `zooPBP`.`Vrsta` (`id_vrste`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zooPBP`.`Eksponat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zooPBP`.`Eksponat` (
  `id_kaveza` INT(11) NOT NULL,
  `id_zivotinje` INT(11) NOT NULL,
  `datum_useljenja` DATE NOT NULL,
  PRIMARY KEY (`id_kaveza`, `id_zivotinje`),
  INDEX `fk_Eksponat_Kavez1_idx` (`id_kaveza` ASC),
  INDEX `fk_Eksponat_Zivotinja1_idx` (`id_zivotinje` ASC),
  CONSTRAINT `fk_Eksponat_Kavez1`
    FOREIGN KEY (`id_kaveza`)
    REFERENCES `zooPBP`.`Kavez` (`id_kaveza`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Eksponat_Zivotinja1`
    FOREIGN KEY (`id_zivotinje`)
    REFERENCES `zooPBP`.`Zivotinja` (`id_zivotinje`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zooPBP`.`Hrana`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zooPBP`.`Hrana` (
  `id_hrane` INT(11) NOT NULL AUTO_INCREMENT,
  `id_dobavljaca` INT(11) NOT NULL,
  `kolicina_u_skladistu` INT(11) NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_hrane`),
  INDEX `fk_Hrana_Dobavljac1_idx` (`id_dobavljaca` ASC),
  CONSTRAINT `fk_Hrana_Dobavljac1`
    FOREIGN KEY (`id_dobavljaca`)
    REFERENCES `zooPBP`.`Dobavljac` (`id_dobavljaca`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zooPBP`.`Privremeni_kavez`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zooPBP`.`Privremeni_kavez` (
  `id_kaveza` INT(11) NOT NULL,
  `id_privremenog` INT(11) NOT NULL,
  PRIMARY KEY (`id_kaveza`, `id_privremenog`),
  INDEX `fk_Privremeni_kavez_Kavez2_idx` (`id_privremenog` ASC),
  CONSTRAINT `fk_Privremeni_kavez_Kavez1`
    FOREIGN KEY (`id_kaveza`)
    REFERENCES `zooPBP`.`Kavez` (`id_kaveza`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Privremeni_kavez_Kavez2`
    FOREIGN KEY (`id_privremenog`)
    REFERENCES `zooPBP`.`Kavez` (`id_kaveza`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zooPBP`.`Raspored_hranjenja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zooPBP`.`Raspored_hranjenja` (
  `id_zivotinje` INT(11) NOT NULL,
  `id_hrane` INT(11) NOT NULL,
  `vreme_hranjenja` DATETIME NOT NULL,
  `kolicina` INT(11) NOT NULL,
  INDEX `fk_Raspored_hranjenja_Hrana1_idx` (`id_hrane` ASC),
  INDEX `fk_Raspored_hranjenja_Zivotinja1_idx` (`id_zivotinje` ASC),
  PRIMARY KEY (`id_zivotinje`, `id_hrane`, `vreme_hranjenja`),
  CONSTRAINT `fk_Raspored_hranjenja_Hrana1`
    FOREIGN KEY (`id_hrane`)
    REFERENCES `zooPBP`.`Hrana` (`id_hrane`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Raspored_hranjenja_Zivotinja1`
    FOREIGN KEY (`id_zivotinje`)
    REFERENCES `zooPBP`.`Zivotinja` (`id_zivotinje`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zooPBP`.`Zdravstveni_kartoni`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zooPBP`.`Zdravstveni_kartoni` (
  `id_kartona` INT(11) NOT NULL AUTO_INCREMENT,
  `id_zivotinje` INT(11) NOT NULL,
  `opis` VARCHAR(500) NOT NULL,
  `datum_poslednjeg_pregleda` DATE NULL,
  `datum_kontrole` DATE NOT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'otvoren',
  PRIMARY KEY (`id_kartona`),
  INDEX `fk_Zdravstveni_kartoni_Zivotinja1` (`id_zivotinje` ASC),
  CONSTRAINT `fk_Zdravstveni_kartoni_Zivotinja1`
    FOREIGN KEY (`id_zivotinje`)
    REFERENCES `zooPBP`.`Zivotinja` (`id_zivotinje`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
PACK_KEYS = DEFAULT;


-- -----------------------------------------------------
-- Table `zooPBP`.`Terapija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zooPBP`.`Terapija` (
  `id_terapije` INT NOT NULL AUTO_INCREMENT,
  `id_kartona` INT(11) NOT NULL,
  `datum_pocetka` DATE NOT NULL,
  `datum_kraja` DATE NOT NULL,
  `dijagnoza` VARCHAR(500) NOT NULL,
  INDEX `fk_Terapija_Zdravstveni_kartoni1_idx` (`id_kartona` ASC),
  PRIMARY KEY (`id_terapije`, `id_kartona`),
  CONSTRAINT `fk_Terapija_Zdravstveni_kartoni1`
    FOREIGN KEY (`id_kartona`)
    REFERENCES `zooPBP`.`Zdravstveni_kartoni` (`id_kartona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
