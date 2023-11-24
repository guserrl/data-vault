## Projecto data vault

#### Uando SNOWFLAKE_SAMPLE_DATA

Se a usado este schema de snowflake como datos para crear el data vault, primero se a realizado una copia del schema para poder editar y realizar pruebas de insercion y modificacion, y se a añadido la columna fresh_data para comprobar el freshness de los datos.
![dbt Logo](https://docs.snowflake.com/en/_images/sample-data-tpch-schema.png)

#### Modelado inicial
[link](https://dbdiagram.io/d/Data-vault-651fb156ffbf5169f02825a3)  
[estrella](https://dbdiagram.io/d/modelo-dimensional-star-655b543e3be1495787597ac8)

#### Descripcion

El projecto consiste en diseñar e implementar la arquitectura y flujo de datos completo y acotado que simule una arquitectura Data Vault 2.0  
Dentro del projecto podemos encontrar:
  - la carpeta macros: Que contien las macros usadas para construir los modelos hub,satellite, link y las cargas incrementales y full
  - los ficheros de configuracion  

Dentro de la carpeta models encontramos:
  - stagin: capa staging del projecto
  - historico: se tendra un historico de la evolucion de los datos a medida que se realizan sus cargas
  - data-vault: contiene los modelos de los hub,satelites,links,bridge y pit del data vault  
  - dim: contiene los modelos del modelado dimensional en estrella


#### Resources:

- [ Error comun](https://discourse.getdbt.com/t/package-installation-fails-on-windows-when-directory-paths-are-very-long/5007)
- [Intalacion dbt core](https://docs.getdbt.com/docs/core/installation)
- [Elementary](https://docs.elementary-data.com/introduction)

### dbt core
  Para los teste de freshnes, primero usar dbt source freshness

### Cosas
- [ 1](https://superuser.com/questions/341192/how-can-i-display-the-contents-of-an-environment-variable-from-the-command-promp)
- [ 2](https://stackoverflow.com/questions/71920945/env-var-required-but-not-provided-dbt-cli)
- [ 3](https://medium.com/indiciumtech/understanding-dbt-incremental-strategies-part-1-2-22bd97c7eeb5)
- [4](https://fivetran.com/docs/transformations/dbt/faq/duplicate-row-detected)  
- [5](https://www.elementary-data.com/post/dbt-tests)  
- [6](https://dev.to/flippedcoding/difference-between-development-stage-and-production-d0p)  
- [7](https://docs.getdbt.com/best-practices/best-practice-workflows)  
- [8](https://docs.getdbt.com/reference/commands/cmd-docs)  
- [9](https://stackoverflow.com/help/minimal-reproducible-example)  
- [10](https://www.montecarlodata.com/blog-8-data-quality-issues)  
- [11](https://www.datafold.com/blog/7-dbt-testing-best-practices)  
- [12](https://medium.com/indiciumtech/17-dbt-commands-you-should-start-using-today-581998dbf8f0)  
- [13](https://www.databricks.com/glossary/star-schema#:~:text=A%20star%20schema%20is%20used,like%20transaction%20amounts%20and%20quantities).)  
- [14](https://www.sqlshack.com/implementing-slowly-changing-dimensions-scds-in-data-warehouses/)  
- [15](https://www.ibm.com/docs/es/ida/9.1.2?topic=schemas-star)  
- [16](https://www.ibm.com/docs/es/db2-for-zos/13?topic=modeling-normalization-in-database-design)  
- [17](https://popsql.com/learn-dbt/dbt-snapshot)  
- [18](https://medium.com/@vigneshwaran18/scd-using-dbt-and-snowflake-145a2092a713)