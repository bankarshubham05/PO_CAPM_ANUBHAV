using CatalogService as service from '../../srv/CatalogService';
annotate service.POs with @(
  //Filter Area
  UI.SelectionFields:[
    PO_ID,
    PARTNER_GUID.COMPANY_NAME,
    PARTNER_GUID.ADDRESS_GUID.COUNTRY,
    GROSS_AMOUNT,
    OVERALL_STATUS
  ],
  //Line Item Area
  UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },{
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.boost', 
            Inline : true,
            Label : 'Boost',
        },
        {
            $Type : 'UI.DataField',
            Value : OverStatus,
            Criticality : Criticality
        },
  ],
  //HeaderInfo
  UI.HeaderInfo :{
    TypeName : 'Purchase Order',
    TypeNamePlural: 'Purchase Orders',
    Title : {
        Value: PO_ID
      
    },
    Description :{Value : GROSS_AMOUNT,   Label : 'Gross Amount :'}
  },
  UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label: 'Detailed Information',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.Identification',
                    Label : 'More Info',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing Info',
                    Target : '@UI.FieldGroup#PriceInof'

                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Status Info',
                    Target : '@UI.FieldGroup#Statusinfo',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'Items/@UI.LineItem',
            Label : 'PO Items',
        }

  ],

  UI.Identification :[
    {
        $Type : 'UI.DataField',
        Value : NODE_KEY,
    },
    {
        $Type : 'UI.DataField',
        Value : PO_ID,
    },
    {
        $Type : 'UI.DataField',
        Value : PARTNER_GUID_NODE_KEY
    },
  ],
  UI.FieldGroup#PriceInof :{
    Label : 'Price Info',
    Data : [
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
    ],
    
  },
  UI.FieldGroup#Statusinfo:{
    Label:'Status Inof',
    Data : [
        {
            $Type : 'UI.DataField',
            Value : OVERALL_STATUS,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ],
  }



);

annotate service.PurchaseOrderItems with @(
    UI.HeaderInfo:{
        TypeName : 'PO Item',
        TypeNamePlural: 'PO Items',
        Title : {
         Value: PO_ITEM_POS
        },
        Description :{
            Value : PRODUCT_GUID.DESCRIPTION,
            Label: 'Description'
        }
    },
    UI.Facets :[
        {
            Label : 'Items Details',
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.Identification',
        },
    ],
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.DESCRIPTION
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ],
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ]
);

annotate service.POs with {
    PARTNER_GUID @(
        Common : { 
            Text : PARTNER_GUID.COMPANY_NAME,
         },
         ValueList.entity: CatalogService.BusinessPartnerSet
    )
};

annotate service.PurchaseOrderItems with {
    PRODUCT_GUID @(
        Common : { 
            Text : PRODUCT_GUID.DESCRIPTION
         },
         ValueList.entity: CatalogService.ProductSet
    )
};


@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    }]
);

@cds.odata.valuelist
annotate service.ProducuctSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : DESCRIPTION,
    }]
);



