$(function () {
    $('.plus-minus').each(function () {
        var count = 1,
            minValue = 1,
            maxValue = 100;           

        var minusBtn = $(this).children('.minus')
        var feild = $(this).children('.plus-minus__feild')
        var plusBtn = $(this).children('.plus')

        feild.val(count);

        minusBtn.on('click', minus)

        plusBtn.on('click', plus)        

        feild.on('input', onInput);     

        function minus(){
            if(count >= minValue){
                count--
                feild.val(count)
            }
        }
        
        function plus(){
            if(count <= maxValue){
                count++
                feild.val(count)
            }
        }   

        function paste(number) {
            count = test(number)
            feild.val(count)
        }

        function test(number) {
            var num = Number(number)

            console.log(num)

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
