/**
 * r-slider init파일
 */
(function () {
    'use strict';

    var init = function () {                

     

        var slider = new rSlider({
            target: '#slider',
            values: [2014, 2015, 2016, 2017, 2018],
            range: true,
            set: [2017, 2018],
            onChange: function (vals) {
                console.log(vals);
            }
        });
    };
    window.onload = init;
})();