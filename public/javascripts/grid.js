
Ext.onReady(function() {

  Ext.QuickTips.init();

  // turn on validation errors beside the field globally
  Ext.form.Field.prototype.msgTarget = 'side';

  var myStore = new Ext.data.JsonStore({
		  url: '/recipes.json',
		  fields: ['id', 'name', 'difficulty'],
		  autoLoad: true
  });

  var sm = new Ext.grid.CheckboxSelectionModel();

  var grid = new Ext.ux.GridFormBinding({
					  restfulPaths: {
					    create: '/recipes/create',
					    update: '/recipes/update/',
					    delete: '/recipes/delete/'
					  },

					  title: 'Ricette',
					  width: 400,

					  grid: {
					    store: myStore,
					    autoHeight: true,
					    autoExpandColumn: 'name',
					    stripeRows: true,
					    sm: new Ext.grid.CheckboxSelectionModel(),

					    columns: [
					      sm,
					      {header: 'Id', sortable: true, dataIndex: 'id'},
					      {id: 'name', header: 'Nome', sortable: true, dataIndex: 'name'}
					    ],

					    viewConfig: {
					      emptyText: 'Your database is empty.'
					    }
					  },

					  form: {
					    title: 'Dettagli Ricetta',
					    frame: true,
					    defaultType: 'textfield',
					    defaults: {
					      width: 200
					    },

					    items: [

					      {fieldLabel: 'Ricetta', name: 'name'},

					      new Ext.form.ComboBox({
						id: 'combo',
						mode: 'local',
						name: 'difficulty',
						editable: false,
						selectOnFocus: true,
						forceSelection: true,
						triggerAction: 'all',
						fieldLabel: 'Difficoltà',
						hiddenName: 'difficulty',
						store: [['0', 'Bassa'], ['1', 'Media'], ['2', 'Alta']],
						valueField: 'value',
						displayField: 'difficulty'
					      }),

					      {hideLabel: true, hidden: true, name: 'id'}
					    ]
					  }

					});

  grid.render(document.body);

});

