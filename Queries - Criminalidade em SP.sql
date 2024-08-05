-- Total de Crimes por Delegacia e Ano (Consulta utilizada para elaboração do dashboard no Looker Studio)
WITH
  Total_Crimes AS(
  SELECT
    Delegacia AS delegacia,
    SUM(`Furtos na região`) AS furto_regiao,
    SUM(`Roubo de carga`) AS roubo_carga,
    SUM(Roubos) AS roubos,
    SUM(`Roubo de Veiculo`) AS roubo_veiculo,
    SUM(`Furto de veiculo` ) AS furto_veiculo,
    SUM(Latrocinios) AS latrocinio,
    SUM(`Homicídio doloso por acidente de trânsito`) AS homicidio_doloso,
    SUM(`Homicídio Culposo por acidente de Trânsito`) AS homicidio_culposo_transito,
    SUM(`Homicídio Culposo`) AS homicidio_culposo,
    SUM(`Tentativa de Homicídio`) AS tentativa_homicidio,
    SUM(`Lesão Corporal seguida de morte`) AS lesao_corporal_morte,
    SUM(`Lesão Corporal Dolosa`) AS lesao_corporal_dolosa,
    SUM(`Lesão Corporal Culposa por acidente de trânsito`) AS lesao_corporal_transito,
    SUM(`Lesão Corporal Culposa`) AS lesao_corporal_culposa,
    SUM(Estupro) AS estupro,
    SUM(`Estupro de vulnerável`) AS estupro_vulneravel,
    SUM(`Roubo de veiculos`) AS roubo_veiculos,
    SUM(`Roubo a Banco `) AS roubo_banco,
    Ano AS ano
  FROM
    `crimes.sp`
  GROUP BY
    delegacia,
    ano)
SELECT
  delegacia,
   roubo_carga,
  roubos,
  roubo_veiculo,
  latrocinio,
  roubo_veiculos,
  roubo_banco,
  furto_regiao,
  furto_veiculo,
  homicidio_doloso,
  homicidio_culposo_transito,
  homicidio_culposo,
  tentativa_homicidio,
  lesao_corporal_morte,
  lesao_corporal_dolosa,
  lesao_corporal_transito,
  lesao_corporal_culposa,
  estupro,
  estupro_vulneravel,
  (furto_regiao + roubo_carga + roubos + roubo_veiculo + furto_veiculo+latrocinio+homicidio_doloso+homicidio_culposo_transito+homicidio_culposo+tentativa_homicidio+lesao_corporal_morte+lesao_corporal_dolosa+lesao_corporal_transito+lesao_corporal_culposa+estupro+estupro_vulneravel+roubo_veiculos+roubo_banco) 
  AS total_crimes,
  ano,
FROM
  Total_Crimes
ORDER BY
  ano,
  total_crimes 
  DESC;







-- Diferença Percentual de 2019 para 2020 por Delegacia
WITH
  Total_Crimes AS(
  SELECT
    Delegacia AS delegacia,
    SUM(`Furtos na região`) AS furto_regiao,
    SUM(`Roubo de carga`) AS roubo_carga,
    SUM(Roubos) AS roubos,
    SUM(`Roubo de Veiculo`) AS roubo_veiculo,
    SUM(`Furto de veiculo` ) AS furto_veiculo,
    SUM(Latrocinios) AS latrocinio,
    SUM(`Homicídio doloso por acidente de trânsito`) AS homicidio_doloso,
    SUM(`Homicídio Culposo por acidente de Trânsito`) AS homicidio_culposo_transito,
    SUM(`Homicídio Culposo`) AS homicidio_culposo,
    SUM(`Tentativa de Homicídio`) AS tentativa_homicidio,
    SUM(`Lesão Corporal seguida de morte`) AS lesao_corporal_morte,
    SUM(`Lesão Corporal Dolosa`) AS lesao_corporal_dolosa,
    SUM(`Lesão Corporal Culposa por acidente de trânsito`) AS lesao_corporal_transito,
    SUM(`Lesão Corporal Culposa`) AS lesao_corporal_culposa,
    SUM(Estupro) AS estupro,
    SUM(`Estupro de vulnerável`) AS estupro_vulneravel,
    SUM(`Roubo de veiculos`) AS roubo_veiculos,
    SUM(`Roubo a Banco `) AS roubo_banco,
    Ano AS ano
  FROM
    `crimes.sp`
  GROUP BY
    delegacia,
    ano),
Crimes_2019 AS(
  SELECT
    delegacia,
    (furto_regiao + roubo_carga + roubos + roubo_veiculo + furto_veiculo+latrocinio+homicidio_doloso+homicidio_culposo_transito+homicidio_culposo+tentativa_homicidio+lesao_corporal_morte+lesao_corporal_dolosa+lesao_corporal_transito+lesao_corporal_culposa+estupro+estupro_vulneravel+roubo_veiculos+roubo_banco) AS total_2019
  FROM
    Total_Crimes
  WHERE
    ano = 2019),
Crimes_2020 AS (
  SELECT
    delegacia,
    (furto_regiao + roubo_carga + roubos + roubo_veiculo + furto_veiculo+latrocinio+homicidio_doloso+homicidio_culposo_transito+homicidio_culposo+tentativa_homicidio+lesao_corporal_morte+lesao_corporal_dolosa+lesao_corporal_transito+lesao_corporal_culposa+estupro+estupro_vulneravel+roubo_veiculos+roubo_banco) AS total_2020
  FROM 
    Total_Crimes
  WHERE
    ano = 2020
)
SELECT
  crimes20.delegacia AS Delegacia,
  ROUND((1 - SUM(crimes20.total_2020)/SUM(crimes19.total_2019))*100,1) AS `Diferença Percentual`
FROM
  Crimes_2019 crimes19
JOIN
  Crimes_2020 crimes20
ON
  crimes19.delegacia = crimes20.delegacia
WHERE
  total_2019 > 0 AND total_2020 > 0
GROUP BY
  delegacia
ORDER BY
  `Diferença Percentual` DESC;








-- Total de Crimes por Ano
WITH
  Total_Crimes AS(
  SELECT
    SUM(`Furtos na região`) AS furto_regiao,
    SUM(`Roubo de carga`) AS roubo_carga,
    SUM(Roubos) AS roubos,
    SUM(`Roubo de Veiculo`) AS roubo_veiculo,
    SUM(`Furto de veiculo` ) AS furto_veiculo,
    SUM(Latrocinios) AS latrocinio,
    SUM(`Homicídio doloso por acidente de trânsito`) AS homicidio_doloso,
    SUM(`Homicídio Culposo por acidente de Trânsito`) AS homicidio_culposo_transito,
    SUM(`Homicídio Culposo`) AS homicidio_culposo,
    SUM(`Tentativa de Homicídio`) AS tentativa_homicidio,
    SUM(`Lesão Corporal seguida de morte`) AS lesao_corporal_morte,
    SUM(`Lesão Corporal Dolosa`) AS lesao_corporal_dolosa,
    SUM(`Lesão Corporal Culposa por acidente de trânsito`) AS lesao_corporal_transito,
    SUM(`Lesão Corporal Culposa`) AS lesao_corporal_culposa,
    SUM(Estupro) AS estupro,
    SUM(`Estupro de vulnerável`) AS estupro_vulneravel,
    SUM(`Roubo de veiculos`) AS roubo_veiculos,
    SUM(`Roubo a Banco `) AS roubo_banco,
    Ano AS ano
  FROM
    `crimes.sp`
  GROUP BY
    ano)
SELECT
  ano,
  (furto_regiao + roubo_carga + roubos + roubo_veiculo + furto_veiculo+latrocinio+homicidio_doloso+homicidio_culposo_transito+homicidio_culposo+tentativa_homicidio+lesao_corporal_morte+lesao_corporal_dolosa+lesao_corporal_transito+lesao_corporal_culposa+estupro+estupro_vulneravel+roubo_veiculos+roubo_banco) AS total_crimes
FROM
  Total_Crimes
ORDER BY
  ano; 






-- Diferença Percentual da Criminalidade em Geral
WITH
  Total_Crimes AS(
  SELECT
    SUM(`Furtos na região`) AS furto_regiao,
    SUM(`Roubo de carga`) AS roubo_carga,
    SUM(Roubos) AS roubos,
    SUM(`Roubo de Veiculo`) AS roubo_veiculo,
    SUM(`Furto de veiculo` ) AS furto_veiculo,
    SUM(Latrocinios) AS latrocinio,
    SUM(`Homicídio doloso por acidente de trânsito`) AS homicidio_doloso,
    SUM(`Homicídio Culposo por acidente de Trânsito`) AS homicidio_culposo_transito,
    SUM(`Homicídio Culposo`) AS homicidio_culposo,
    SUM(`Tentativa de Homicídio`) AS tentativa_homicidio,
    SUM(`Lesão Corporal seguida de morte`) AS lesao_corporal_morte,
    SUM(`Lesão Corporal Dolosa`) AS lesao_corporal_dolosa,
    SUM(`Lesão Corporal Culposa por acidente de trânsito`) AS lesao_corporal_transito,
    SUM(`Lesão Corporal Culposa`) AS lesao_corporal_culposa,
    SUM(Estupro) AS estupro,
    SUM(`Estupro de vulnerável`) AS estupro_vulneravel,
    SUM(`Roubo de veiculos`) AS roubo_veiculos,
    SUM(`Roubo a Banco `) AS roubo_banco,
    Ano AS ano
  FROM
    `crimes.sp`
  GROUP BY
    ano),
Crimes_19 AS(
  SELECT
  ano,
  (furto_regiao + roubo_carga + roubos + roubo_veiculo + furto_veiculo+latrocinio+homicidio_doloso+homicidio_culposo_transito+homicidio_culposo+tentativa_homicidio+lesao_corporal_morte+lesao_corporal_dolosa+lesao_corporal_transito+lesao_corporal_culposa+estupro+estupro_vulneravel+roubo_veiculos+roubo_banco) AS total_crimes_2019
  FROM
    Total_Crimes 
  WHERE
    ano = 2019
),
Crimes_20 AS(
  SELECT
  ano,
  (furto_regiao + roubo_carga + roubos + roubo_veiculo + furto_veiculo+latrocinio+homicidio_doloso+homicidio_culposo_transito+homicidio_culposo+tentativa_homicidio+lesao_corporal_morte+lesao_corporal_dolosa+lesao_corporal_transito+lesao_corporal_culposa+estupro+estupro_vulneravel+roubo_veiculos+roubo_banco) AS total_crimes_2020
  FROM
    Total_Crimes 
  WHERE
    ano = 2020
)
SELECT
  ROUND((1 - (total_crimes_2020/total_crimes_2019))*100,2) AS `Diferença Anual Geral`
FROM 
  Crimes_19, Crimes_20;
