$(function () {
    $('.plus-minus').each(function () {
        
        var plusminus = $(this),
            minusBtn = $(this).children('.minus'),
            feild = $(this).children('.plus-minus__feild'),
            plusBtn = $(this).children('.plus');
        
        var count = Number($(this).attr('data-value')) || 1,
            minValue = Number($(this).attr('data-min-value')) || 1,
            maxValue = Number($(this).attr('data-max-value')) || 100;  
                    
        feild.val(count);
        plusminus.data('count', count)

        minusBtn.on('click', minus)

        plusBtn.on('click', plus)        

        feild.on('input', onInput);     

        function minus(){
            if(count > minValue){
                count--
                feild.val(count)
                plusminus.trigger('count', count)
                plusminus.data('count', count)
            }
        }
        
        function plus(){
            if(count < maxValue){
                count++
                feild.val(count)
                plusminus.trigger('counted', count)
                plusminus.data('count', count)
            }
        }   

        function paste(number) {
            count = test(number)
            feild.val(count)
            plusminus.trigger('counted', count)
            plusminus.data('count', count)
        }

        function test(number) {
            var num = Number(number)

            if(!num)
                return minValue

            if(num > maxValue)
                return maxValue

            if(num < minValue)
                return minValue

            return number
        }        

        function onInput(event) {
            paste(feild.val())
        }

        
    })
})
