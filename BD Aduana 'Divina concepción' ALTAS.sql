INSERT INTO empresa(id_empresa, nombre)
VALUES ("PESCA", "Pescados"),
("MFERR", "Máquinas Férreas"),
("VFRES", "Vegetales Frescos"),
("ACHOC", "Autos Chocadores"),
("LIMAB", "Limpieza Absoluta"),
("TFACT", "Toxic Factory"),
("LDANG", "Dangers Liquids"),
("ANIMA", "Animals"),
("MFUNC", "Máquinas Funcionales"),
("CFOOD", "Cheap Food");

INSERT INTO modelo (modelo, capacidad_max_tripulantes, cargamento_max)
VALUES ("Astondoa", 90, 50000),
("Azimut", 90, 25000),
("Cranchi", 85, 31005),
("Fairline", 55, 48750),
("Princess Yachts", 71, 52000),
("Quicksilver", 60, 32555),
("Rodman", 55, 38010),
("Sea Ray", 65, 26255),
("Fat Ship", 50, 34100),
("Crucial Line", 80, 45000);

INSERT INTO embarcaciones (id_barco, id_modelo)
VALUES ("AAA111", 8),
("ACA147", 3),
("BAE521", 3),
("ACC007", 7),
("KDL750", 6),
("PEO172", 4),
("UUR964", 9),
("YRI012", 9),
("GWO565", 5),
("MNW183", 1),
("VEG777", 10),
("WIL812", 5),
("ASD069", 2),
("LIK123", 2),
("FWA235", 2);

INSERT INTO navegantes (nombre, apellido, apellido2, fecha_nac, cargo, id_barco)
VALUES ("Jorge", "Casemiro", NULL, "1957/06/12", "Capitán General", "LIK123"),
("Gerónimo", "Arroz", "Fernández", "1966/08/09", "Navegante", "ASD069"),
("Federico", "Ramos", "Mejía", "1990/11/11", "Repartidor", "KDL750"),
("Gonzalo", "Hernández", NULL, "1990/02/28", "Guardia", "ACA147"),
("Roberto", "Finca", NULL, "1971/10/09", "Sub-Capitán", "PEO172"),
("Hernán", "Gómez", "Piraña", "1986/06/23", "Repartidor", "AAA111"),
("Luciano", "Castro", NULL, "2000/01/31", "Repartidor", "WIL812"),
("Marcos", "Sastre", NULL, "1991/07/07", "Navegante", "VEG777"),
("Juliana", "Rodriguez", NULL, "1989/09/12", "Navegante", "KDL750"),
("Verónica", "Gómez", "Trujillo", "1980/11/01", "Sub-Capitán", "FWA235"),
("Jimena", "Hernández", NULL, "1992/10/18", "Guardia", "GWO565"),
("Barbie", "Manola", NULL, "1983/12/05", "Guardia", "ACC007"),
("Rodrigo", "Fernández", "Muñoz", "1951/12/05", "Capitán General", "ACC007"),
("Jack", "Gordon", "Uri", "1985/12/05", "Capitán General", "UUR964"),
("Uriel", "Camavinga", NULL, "2001/12/21", "Repartidor", "BAE521"),
("Nora", "Banderas", "Fiumba", "1978/07/11", "Sub-Capitán", "YRI012"),
("Mariana", "Diaz", "Nochez", "1966/01/05", "Repartidor", "UUR964"),
("Lautaro", "Tarugo", NULL, "2005/10/02", "Repartidor", "MNW183"),
("Cesar", "Julio", "Chavez", "1960/04/17", "Capitán General", "AAA111");

INSERT INTO tipo_producto (id_tipo, descripcion, impuesto)
VALUES ("ORGANICOS", "Comida orgánica", 65125.5),
("MAQUINARIA", "Máquinas y/o aparatos funcionales de grandes dimensiones y pesos", 87943.3),
("ANIMAL", "Seres animales de tipos y razas específicas", 152539.7),
("ARTIFICIAL", "Alimentos/comidas creadas con adiciones químicas y/o aditivos", 81643.1),
("TOXICOS", "Sutancias tóxicas y peligrosas para el ser humano", 111145.4),
("QUIMICOS", "Sustancias o componentes químicos que pueden ser maniobrados por el ser humano sin provocarle prejuicio alguno", 98124.7),
("VEHICULOS", "Transportes terrestres, subterráneos o aéreos.", 237321.5);

INSERT INTO producto (id_tipo, id_empresa, id_barco, descripcion, peso, valor)
VALUES ("VEHICULOS", "ACHOC", "LIK123", "Automóvil promedio de buena calidad con capacidad para cuatro personas", 1700.0, 7899999.9),
("ANIMAL", "ANIMA", "BAE521", "Animal de tipo vaca", 1110.5, 182000),
("ORGANICOS", "PESCA", "MNW183", "Pescado grande", 1.0, 4000),
("ARTIFICIAL", "CFOOD", "KDL750", "Hamburguesa de pocos ingredientes", 0.150, 3500.0),
("TOXICOS", "LDANG", "UUR964", "Mercurio líquido", 1.0, 700),
("QUIMICOS", "LIMAB", "YRI012", "Cloro granulado disolución lenta", 5.0, 24449.9),
("MAQUINARIA", "MFERR", "AAA111", "Máquina de coser industrial", 125.0, 463339.9),
("MAQUINARIA", "MFUNC", "FWA235", "Máquina extendedora de balasto", 5600.0, 42769999.9),
("TOXICOS", "TFACT", "ASD069", "Acetona", 10.0, 65000.0),
("ORGANICOS", "VFRES", "ACC007", "Lechuga de campo", 1.0, 700.0);

INSERT INTO puertos (id_puerto, ubicacion, pais, nombre_puerto, telefono, capacidad)
VALUES ("PUERTOBSAS", "Encarnación Ezcurra, Buenos Aires", "Argentina", "Puerto de Buenos Aires", NULL, 15),
("SHANGHAI", "Shengsi County, Zhoushan", "China", "Port of Shanghai", NULL, 45),
("PSINGAPUR", "Pasir Panjang", "Singapur", "Puerto de Singapur", NULL, 40),
("SHENZHEN", "Shenzhen, Guangdong", "China", "Puerto de Shenzhen", NULL, 30),
("GUANGZHOU", "Guangzhou, Cantón", "China", "Puerto de Cantón", NULL, 35),
("PTOBUSAN", "Busan", "Corea del Sur", "Puerto de Busan", NULL, 25),
("PTOHGKG", "Hong Kong", "China", "Puerto de Hong Kong", NULL, 20),
("SANTOS", "Santos, San Pablo", "Brasil", "Puerto de Santos", NULL, 25),
("PTOMANZA", "Manzanillo, Colima", "México", "Puerto de Manzanillo", NULL, 15),
("VALENCIA", "Valencia", "España", "Port de Valencia", NULL, 25);

INSERT INTO inspecciones (id_puerto, id_barco, fecha_inspeccion, estado, motivo_detencion, arancel)
VALUES ("GUANGZHOU", "FWA235", "2023/04/12", "Denegado", "Transporte de estupefacientes ilegales (cocaína)", 4277000),
("PSINGAPUR", "BAE521", "2022/07/15", "Pendiente", NULL, 18200),
("PTOBUSAN", "MNW183", "2022/09/09", "Pendiente", NULL, 400),
("PTOHGKG", "KDL750", "2023/01/26", "Aceptado", NULL, 350),
("PTOMANZA", "KDL750", "2023/08/11", "Pendiente", NULL, 350),
("PUERTOBSAS", "AAA111", "2022/05/04", "Aceptado", NULL, 46334),
("SANTOS", "YRI012", "2022/09/01", "Denegado", "Exceso de productos permitidos para traslado", 2444.99),
("SHANGHAI", "ASD069", "2022/11/18", "Denegado", "Producto no permitido para el país destino", 6500),
("SHENZHEN", "UUR964", "2023/12/05", "Aceptado", NULL, 70),
("VALENCIA", "LIK123", "2023/03/19", "Aceptado", NULL, 790000);