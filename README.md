## Projecto data vault

#### Uando SNOWFLAKE_SAMPLE_DATA

![dbt Logo](https://docs.snowflake.com/en/_images/sample-data-tpch-schema.png)

#### Modelado inicial
Este modelado no e sel final, es un modeladoinicial sobre le cual luego en dbt se incluyeron cambios amedida que se iba trabajando en el proyecto
[link](https://dbdiagram.io/d/Data-vault-651fb156ffbf5169f02825a3)


#### Descripcion

El projecto consiste en diseñar e implementar la arquitectura y flujo de datos completo y acotado que simule una arquitectura Data Vault 2.0.  
Dentro del projecto podemos encontrar:
  - la carpeta macros: Que contien las macros usadas para construir los modelos hub,satellite, link y las cargas incrementales y full
  - los ficheros de configuracion 

Dentro de la carpeta models encontramos:
  - stagin: capa staging del projecto
  - historico: se tendra un historico de la evolucion de los datos a medida que se realizan sus cargas
  - data-vault: contiene los modelos de los hub,satelites,links,bridge y pit del data vault


#### Repositorio elementary
En [este repositorio]() se a travajado con la version dbt core y usado elemental CLI para producir graficos de los test

#### Resources:

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](http://community.getbdt.com/) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
