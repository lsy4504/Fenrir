/**
 * 네이버 맵을 가져오기위한 js 입니다.
 */
proj4.defs("EPSG:5179","+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs");
proj4.defs("EPSG:10025","+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs");
proj4.defs("EPSG:5174","+proj=tmerc +lat_0=38 +lon_0=127.0028902777778 +k=1 +x_0=200000 +y_0=500000 +ellps=bessel +units=m +no_defs +towgs84=-115.80,474.99,674.11,1.16,-2.31,-1.63,6.43");
ol.proj.setProj4 = proj4;
var resolutions = [ 2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1, 0.5,
		0.25 ];
var extent = [ 90112, 1192896, 2187264, 2765760 ]; // 4 * 3
var koreanProj = ol.proj.get('EPSG:10025');
var koreanProj1 = ol.proj.get('EPSG:5174');
var projection = new ol.proj.Projection({
	code : 'EPSG:5179',
	extent : extent,
	units : 'm'
});
var view = new ol.View({
	// projection:'EPSG:5174',

	center : ol.proj.transform([ 127.3, 36.5 ], 'EPSG:4326', 'EPSG:3857'),
	zoom : 10
// projection:koreanProj1
// extent:ol.proj.transformExtent([4,46,16,56],'EPSG:5181',epsg5181)
});

var container = document.getElementById('popup');
var content = document.getElementById('popup-content');
var closer = document.getElementById('popup-closer');
var tileLayer = new ol.layer.Tile(
		{
			title : 'Naver Street Map',
			visible : true,
			type : 'base',
			source : new ol.source.XYZ(
					{
						projection : projection,
						tileSize : 256,
						minZoom : 0,
						maxZoom : resolutions.length - 1,
						tileGrid : new ol.tilegrid.TileGrid({
							extent : extent,
							origin : [ extent[0], extent[1] ],
							resolutions : resolutions
						}),
						tileUrlFunction : function(tileCoord, pixelRatio,
								projection) {
							if (tileCoord == null)
								return undefined;

							var s = Math.floor(Math.random() * 3) + 1; // 1 ~ 4
							var z = tileCoord[0] + 1;
							var x = tileCoord[1];
							var y = tileCoord[2];

							return 'http://onetile' + s
									+ '.map.naver.net/get/149/0/0/' + z + '/'
									+ x + '/' + y + '/bl_vc_bg/ol_vc_an';
						},
						attributions : [ new ol.Attribution(
								{
									html : [ '<a href="http://map.naver.com"><img src="http://static.naver.net/maps2/logo_naver_s.png"></a>' ]
								}) ]
					})
		});
var drawSource = new ol.source.Vector();
var drawVector = new ol.layer.Vector({
	source : drawSource,
	style : new ol.style.Style({
		fill : new ol.style.Fill({
			color : 'rgba(255, 255, 255, 0.2)'
		}),
		stroke : new ol.style.Stroke({
			color : '#ffcc33',
			width : 2
		}),
		image : new ol.style.Circle({
			radius : 7,
			fill : new ol.style.Fill({
				color : '#ffcc33'
			})
		})
	})
});

var map = new ol.Map({
	target : 'map',
	name : 'naver',
	layers : [ new ol.layer.Group({
		title : 'Base Maps',
		layers : [ tileLayer ]
	}), new ol.layer.Group({
		title : 'Tiled WMS',
		layers : []
	}) ],

	view : view,
	controls : ol.control.defaults().extend(
			[ new ol.control.FullScreen(), new ol.control.ZoomSlider() ])

});

var sggWms = new ol.layer.Tile({
	source : new ol.source.TileWMS({
		url : geoServer+'wms',
		params : {
			'LAYERS' : 'geumbang:sgg'
		}
	})
});
map.addLayer(sggWms);
