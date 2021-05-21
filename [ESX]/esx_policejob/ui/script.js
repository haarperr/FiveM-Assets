$(function(){
	window.onload = function(e){
		window.addEventListener('message', function(event){

			var item = event.data;
			if (item !== undefined && item.type === "mcard") {

				if (item.display === true) {
					$('#mcard').delay(100).fadeIn( 0 );
				} else if (item.display === false) {
					$('#mcard').fadeOut( "slow" );
				}
			}

			if (item !== undefined && item.type === "vcard") {

				if (item.display === true) {
					$('#vcard').delay(100).fadeIn( 0 );
				} else if (item.display === false) {
					$('#vcard').fadeOut( "slow" );
				}
			}

			if (item !== undefined && item.type === "bcard") {

				if (item.display === true) {
					$('#bcard').delay(100).fadeIn( 0 );
				} else if (item.display === false) {
					$('#bcard').fadeOut( "slow" );
				}
			}

			if (item !== undefined && item.type === "vucard") {

				if (item.display === true) {
					$('#vucard').delay(100).fadeIn( 0 );
				} else if (item.display === false) {
					$('#vucard').fadeOut( "slow" );
				}
			}

			if (item !== undefined && item.type === "pcard") {

				if (item.display === true) {
					$('#pcard').delay(100).fadeIn( 0 );
				} else if (item.display === false) {
					$('#pcard').fadeOut( "slow" );
				}
			}

			if (item !== undefined && item.type === "yjcard") {

				if (item.display === true) {
					$('#yjcard').delay(100).fadeIn( 0 );
				} else if (item.display === false) {
					$('#yjcard').fadeOut( "slow" );
				}
			}

			if (item !== undefined && item.type === "tcard") {

				if (item.display === true) {
					$('#tcard').delay(100).fadeIn( 0 );
				} else if (item.display === false) {
					$('#tcard').fadeOut( "slow" );
				}
			}

			if (item !== undefined && item.type === "bmcard") {

				if (item.display === true) {
					$('#bmcard').delay(100).fadeIn( 0 );
				} else if (item.display === false) {
					$('#bmcard').fadeOut( "slow" );
				}
			}
		});
	};
});