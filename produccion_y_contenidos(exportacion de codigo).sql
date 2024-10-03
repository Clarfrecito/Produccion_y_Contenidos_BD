SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema produccion_y_contenidos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `produccion_y_contenidos` DEFAULT CHARACTER SET utf8 ;
USE `produccion_y_contenidos` ;

-- -----------------------------------------------------
-- Table `produccion_y_contenidos`.`EstadoProduccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produccion_y_contenidos`.`EstadoProduccion` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `nombre_estado` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_estado`));

-- -----------------------------------------------------
-- Table `produccion_y_contenidos`.`Contenido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produccion_y_contenidos`.`Contenido` (
  `id_contenido` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(255) NOT NULL,
  `sinopsis` TEXT NULL DEFAULT NULL,
  `genero` VARCHAR(100) NULL DEFAULT NULL,
  `fecha_creacion` DATE NULL DEFAULT NULL,
  `fecha_publicacion` DATE NULL DEFAULT NULL,
  `idioma` VARCHAR(50) NULL DEFAULT NULL,
  `formato` VARCHAR(50) NULL DEFAULT NULL,
  `estado_actual_id` INT NULL DEFAULT NULL,
  `palabras_clave` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_contenido`),
  UNIQUE INDEX (`titulo` ASC) VISIBLE,
  INDEX (`estado_actual_id` ASC) VISIBLE,
  CONSTRAINT `fk_estado_actual_id`
    FOREIGN KEY (`estado_actual_id`)
    REFERENCES `produccion_y_contenidos`.`EstadoProduccion` (`id_estado`));

-- -----------------------------------------------------
-- Table `produccion_y_contenidos`.`EquipoProduccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produccion_y_contenidos`.`EquipoProduccion` (
  `id_equipo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  `rol` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_equipo`));

-- -----------------------------------------------------
-- Table `produccion_y_contenidos`.`Contenido_EquipoProduccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produccion_y_contenidos`.`Contenido_EquipoProduccion` (
  `id_contenido` INT NOT NULL,
  `id_equipo` INT NOT NULL,
  PRIMARY KEY (`id_contenido`, `id_equipo`),
  INDEX (`id_equipo` ASC) VISIBLE,
  CONSTRAINT `fk_contenido`
    FOREIGN KEY (`id_contenido`)
    REFERENCES `produccion_y_contenidos`.`Contenido` (`id_contenido`),
  CONSTRAINT `fk_equipo`
    FOREIGN KEY (`id_equipo`)
    REFERENCES `produccion_y_contenidos`.`EquipoProduccion` (`id_equipo`));

-- -----------------------------------------------------
-- Table `produccion_y_contenidos`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produccion_y_contenidos`.`Rol` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `nombre_rol` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_rol`));

-- -----------------------------------------------------
-- Table `produccion_y_contenidos`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produccion_y_contenidos`.`Usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(255) NOT NULL,
  `contraseña` VARCHAR(255) NOT NULL,
  `id_rol` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX (`id_rol` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_rol`
    FOREIGN KEY (`id_rol`)
    REFERENCES `produccion_y_contenidos`.`Rol` (`id_rol`));

-- -----------------------------------------------------
-- Table `produccion_y_contenidos`.`HistorialCambios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produccion_y_contenidos`.`HistorialCambios` (
  `id_cambio` INT NOT NULL AUTO_INCREMENT,
  `id_contenido` INT NULL DEFAULT NULL,
  `fecha_cambio` DATETIME NULL DEFAULT NULL,
  `campo_modificado` VARCHAR(100) NULL DEFAULT NULL,
  `valor_anterior` TEXT NULL DEFAULT NULL,
  `valor_nuevo` TEXT NULL DEFAULT NULL,
  `id_usuario` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_cambio`),
  INDEX (`id_contenido` ASC) VISIBLE,
  INDEX (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_historial_contenido`
    FOREIGN KEY (`id_contenido`)
    REFERENCES `produccion_y_contenidos`.`Contenido` (`id_contenido`),
  CONSTRAINT `fk_historial_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `produccion_y_contenidos`.`Usuario` (`id_usuario`));

-- -----------------------------------------------------
-- Table `produccion_y_contenidos`.`EstadisticasContenido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produccion_y_contenidos`.`EstadisticasContenido` (
  `id_estadistica` INT NOT NULL AUTO_INCREMENT,
  `id_contenido` INT NULL DEFAULT NULL,
  `numero_visualizaciones` INT NULL DEFAULT NULL,
  `puntuacion_promedio` DECIMAL(3,2) NULL DEFAULT NULL,
  `frecuencia_aparicion` INT NULL DEFAULT NULL,
  `tasa_finalizacion` DECIMAL(5,2) NULL DEFAULT NULL,
  `duracion_promedio` DECIMAL(5,2) NULL DEFAULT NULL,
  `fecha_estadistica` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_estadistica`),
  INDEX (`id_contenido` ASC) VISIBLE,
  CONSTRAINT `fk_estadistica_contenido`
    FOREIGN KEY (`id_contenido`)
    REFERENCES `produccion_y_contenidos`.`Contenido` (`id_contenido`));

-- -----------------------------------------------------
-- Table `produccion_y_contenidos`.`Notificaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produccion_y_contenidos`.`Notificaciones` (
  `id_notificacion` INT NOT NULL AUTO_INCREMENT,
  `mensaje` TEXT NULL DEFAULT NULL,
  `fecha_notificacion` DATETIME NULL DEFAULT NULL,
  `id_contenido` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_notificacion`),
  INDEX (`id_contenido` ASC) VISIBLE,
  CONSTRAINT `fk_notificacion_contenido`
    FOREIGN KEY (`id_contenido`)
    REFERENCES `produccion_y_contenidos`.`Contenido` (`id_contenido`));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
