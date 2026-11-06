create database retail_project; --crea la base de datos

create table clientes(
	id_cliente serial primary key, --id autoincremental
	nombre varchar(20) not null, --el nombre no puede ser nulo
	apellido varchar(20) not null, --lo mismo el apellido
	email varchar(50) unique not null, --el email no se puede repetir
	fecha_nacimiento date not null 
);

create table productos(
	id_producto serial primary key, --id autoincremental
	nombre varchar(50) not null, --el nombre no puede ser nulo
	stock int not null, 
	precio decimal(10, 2) not null,
	constraint chk_stock_real check(stock >= 0), --no puede haber stock negativo
	constraint chk_precio_positivo check(precio >= 0) --no pueden ser precios negativos
);

create table ventas(
	id_venta serial primary key,
	id_cliente int not null,
	id_producto int not null,
	cantidad int not null,
	monto decimal(15, 2) not null,
	fecha date not null default current_date,
	constraint chk_cantidad_positiva check(cantidad > 0), --no puede haber una venta de 0 productos
	constraint chk_monto_positivo check(monto > 0), --no se puede hacer una venta nula
	constraint fk_id_cliente foreign key (id_cliente) references clientes(id_cliente), --FK que toma el id de cliente
	constraint fk_id_productos foreign key (id_producto) references productos(id_producto) --FK que toma el id de producto
);

begin;

	insert into clientes (nombre, apellido, email, fecha_nacimiento)
	values
		('Gerardo', 'Rodríguez', 'g.rodriguez@yopmail.com', '1969-11-12'),
		('Mario', 'Carpenter', 'carpinteria.mario@hotmail.com', '1991-03-22'),
		('Dora', 'Voyager', 'dora.voyager@viajesdedora.com', '1984-07-05'),
		('Honorio', 'Filemón', 'whereismymind78@gmail.com', '2002-10-09'),
		('Libertad', 'Devoto', 'libervoto@outlook.com', '1999-02-28');

	insert into productos (nombre, stock, precio)
	values
		('Protectores', 78, 9600.00),
		('Limas', 56, 4947.88),
		('Sticks', 12, 38999.99),
		('Vendas', 67, 3500.00),
		('Guantes', 22, 26849.99);
	
	insert into ventas (id_cliente, id_producto, cantidad, monto)
	values
		(2, 4, 1, 38999.99),
		(1, 2, 2, 9895.76),
		(3, 4, 4, 14000.00),
		(4, 4, 10, 35000.00),
		(2, 5, 1, 26849.99);
	
	insert into productos (nombre, stock, precio) --valor de prueba, para borrar luego
	values
		('Prueba', 1, 1.00);
		
commit; --carga de items en cada tabla

begin;

	update productos
	set precio = precio + 3000
	where nombre = 'Guantes';

	update productos
	set precio = precio - 500
	where nombre = 'Vendas';
		
	update productos
	set precio = precio + 5000
	where nombre = 'Sticks';
		
	update productos
	set precio = precio + 300
	where nombre = 'Limas';
		
	update productos
	set precio = precio + 400
	where nombre = 'Protectores';
	
commit; --update masivo de precios

begin;

	delete from productos
	where nombre = 'Prueba';
	
commit; --eliminacion del producto de prueba
