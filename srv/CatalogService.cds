using {
    anubhav.db.master,
    anubhav.db.transaction
} from '../db/datamodel';
using {cappo.cds.CDSViews} from '../db/CDSView';

//using { cappo.cds } from '../db/CDSView';

service CatalogService @(path: 'CatalogService') {


    // @Capabilities : { Insertable, Deletable: false }
    entity BusinessPartnerSet               as projection on master.businesspartner;
    entity AddressSet                       as projection on master.address;

    @readonly
    entity EmployeeSet                      as projection on master.employees;

    entity PurchaseOrderItems               as projection on transaction.poitems;

    entity POs @(odata.draft.enabled: true) as
        projection on transaction.purchaseorder {
            *,
            //   round(GROSS_AMOUNT) as GROSS_AMOUNT: Decimal(10,2),
            case
                OVERALL_STATUS
                when 'P'
                     then 'Pending'
                when 'A'
                     then 'Approved'
                when 'X'
                     then 'Rejected'
                else 'Open'
            end as OverStatus  : String(10),

            case
                OVERALL_STATUS
                when 'P'
                     then 2
                when 'A'
                     then 3
                when 'X'
                     then 1
                else 2
            end as Criticality : String(20),


            Items              : redirected to PurchaseOrderItems
        }
        actions {
            //Side Effects to update the Data directlty
            @Common.SideEffects : {
                $Type : 'Common.SideEffectsType',
                TargetProperties : [
                    'in/GROSS_AMOUNT',
                ],
            }
            action boost() returns POs;
        }
    entity ProducuctSet as projection on master.product;
   // entity ProductView as projection on CDSViews.ProductView;
    function getLargestOrder() returns POs;

}
