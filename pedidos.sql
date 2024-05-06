use pedidos; 

-- Criação da tabela "Pedidos"
CREATE TABLE Pedidos (
	ID_Pedido INT AUTO_INCREMENT PRIMARY KEY,
	DataPedido DATETIME,
	NomeCliente VARCHAR (100)
);
-- Inserção de dados de exemplo
INSERT INTO Pedidos (DataPedido, NomeCliente) VALUES 
(NOW(), 'Cliente 1'),
(NOW(), 'Cliente 2'),
(now(), 'Cliente 3');

-- Criação da Trigger
DELIMITER $
create trigger RegistroDataCriacaoPedido
BEFORE INSERT ON Pedidos
FOR EACH ROW

BEGIN 
	SET NEW.DataPedido = NOW ();
END;
$
DELIMITER ;

-- Insercao de um novo registro na tabela"Pedidos" sem fornecer a data
INSERT INTO Pedidos (NomeCliente) VALUES ('Novo Cliente');

-- Consulta para verificar os resultados
SELECT * FROM Pedidos;
