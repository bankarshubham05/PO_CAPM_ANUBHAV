sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'cap/po1/managepurchaseorders/test/integration/FirstJourney',
		'cap/po1/managepurchaseorders/test/integration/pages/POsList',
		'cap/po1/managepurchaseorders/test/integration/pages/POsObjectPage',
		'cap/po1/managepurchaseorders/test/integration/pages/PurchaseOrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, PurchaseOrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('cap/po1/managepurchaseorders') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePurchaseOrderItemsObjectPage: PurchaseOrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);