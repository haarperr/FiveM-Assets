$(function(){
	window.onload = function(e){
		window.addEventListener('message', function(event){

			var item = event.data;
			if (item !== undefined && item.type === "gr8_newsstand") {

				if (item.display === true) {
					$('#gr8_newsstand').delay(100).fadeIn( "slow" );
				} else if (item.display === false) {
					$('#gr8_newsstand').fadeOut( "slow" );
				}
			}
		});
	};
});