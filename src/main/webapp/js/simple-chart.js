(function ($) {
    $.fn.simpleChart = function (options) {
        var config = $.extend({
            title: {
                text: 'Simple Chart',
                align: 'right'
            },
            type: 'column', /* progress, bar, waterfall, column */
            layout: {
                width: '100%', /* String value: in px or percentage */
                height: '300px' /* String value: in px or percentage */
            },
            item: {
                label: ['First Label'], // string
                value: [15], //integer
                outputValue: [], // Optimized values: instead of 10240 bytes you can output 10kb if you provide the array
                color: ['#333'],
                prefix: '',
                suffix: '',
                decimals: 2,
                height: null,
                render: {
                    size: 'relative', /* Relative - the height of the items is relative to the maximum value */
                    margin: 0,
                    radius: null
                }
            },
            marker: null
        }, options);

        var template, leftPosition = [], chartType, chartHeight, chartWidth, barColor, barMargin, i, titleAlign;
        config.type ? chartType = config.type : chartType = 'column';
        config.layout.width ? chartWidth = 'width:' + config.layout.width + ';' : chartWidth = '';
        config.layout.height ? chartHeight = 'height:' + config.layout.height + ';' : chartHeight = '';
        config.title.align ? titleAlign = 'text-align:' + config.title.align + ';' : titleAlign = '';
        (config.item.render.margin >= 0) ? barMargin = config.item.render.margin : barMargin = 0.5;


        function getBackgroundColor() {
            var bgColor;
            if (config.item.color.length <= 0) {
                bgColor = '';
            } else if (config.item.color.length == 1) {
                bgColor = 'background-color:' + config.item.color[0] + ';';
            } else {
                bgColor = 'background-color:' + config.item.color[i] + ';'
            }

            return bgColor;
        }

        function recordsClass() {
            var recordClass = '';
            if ((config.item.value.length > 0) && (config.item.value.length <= 10)) {
                recordClass = 'sc-10-items';
            } else if ((config.item.value.length > 10) && (config.item.value.length <= 20)) {
                recordClass = 'sc-20-items';
            } else if (config.item.value.length > 20) {
                recordClass = 'sc-many-items';
            }

            return recordClass;
        }

        function arraySum(arr) {
            var sum = 0;
            for (var i = 0; i < arr.length; i++) {
                sum += arr[i];
            }
            return sum;
        }

        function setItemSize() {
            var itemHeight = [], nominator = 1, maxValue, total;
            maxValue = Math.max.apply(null, config.item.value);
            total = arraySum(config.item.value);

            if (config.item.render.size === 'absolute') {
                nominator = total;
            } else {
                nominator = maxValue;
            }

            for (i = 0; i < config.item.value.length; i++) {
                itemHeight.push(config.item.value[i] * 100 / nominator);
            }
            console.log(config.item.value[i] * 100 / nominator);
            return itemHeight;
        }


        template = '<div class="sc-chart sc-' + chartType + ' ' + recordsClass() + '" style="' + chartWidth + chartHeight + ' margin-bottom:15px;">';
        template += '<div class="sc-title" style="' + titleAlign + '">' + config.title.text + '</div>';
        template += '<div class="sc-canvas">';

        var itemWidth, itemHeight, itemPercentage;




        if (config.type == 'column') {
            itemWidth = (100 - config.item.value.length * barMargin - barMargin) / config.item.value.length;
            itemHeight = setItemSize();
            for (i = 0; i < config.item.value.length; i++) {
                barColor = getBackgroundColor();
                template += '<div class="sc-item" style="left:' + ((itemWidth + barMargin) * i + barMargin) + '%;width:' + (itemWidth) + '%;height:' + itemHeight[i] + '%;' + barColor + '">';
                template += '<span class="sc-label">' + config.item.label[i] + '</span>';
                template += '<span class="sc-value">' + config.item.prefix + (config.item.outputValue[i] || config.item.value[i]) + config.item.suffix + '</span>';
               
                template += '</div>';
            }
        }

        template += '</div>';
        template += '</div>';
        return this.html(template);
    }

})(jQuery);