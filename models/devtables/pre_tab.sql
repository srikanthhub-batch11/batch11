{{ config(
    pre_hook=["UPDATE {{ source('source_model','PRE_TABLE')}} SET P_SIZE = 15 WHERE 
                P_PARTKEY = 7133263" ,   
                "UPDATE {{ source('source_model','PRE_TABLE')}} SET P_SIZE = 19 WHERE 
                P_PARTKEY = 7133264"
                ],
    post_hook = ["DELETE FROM {{ source('source_model','PRE_TABLE')}} where P_SIZE IN (15,19)"]
)}}

SELECT *,({{calculate('P_SIZE','P_RETAILPRICE')}})  AS TOTAL FROM  {{ source('source_model','PRE_TABLE')}}