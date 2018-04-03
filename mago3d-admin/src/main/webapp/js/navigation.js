( function( $ ) {

	$( document ).ready( function() {

		var sub_menus = $( '.site-navigation ul[id^=sub-menu]' );

		if ( sub_menus.length > 0 ) {

			// Create sub menu container
			$( '.site-navigation' ).append( '<div class="sub-menu row"></div>' );

			// Move sub menu items
			sub_menus.each( function() {
				$( '.sub-menu' ).append( $( this ) );
			} );

			// Set sub menu horizontal position
			function setSubMenuPosition() {
				$( '.sub-menu ul' ).each( function() {
					var sub_id = $( this ).attr( 'id' ).slice( 9 );
					var parent = '';
					$( '.main-menu li' ).each( function() {
						var main_id = $( this ).attr( 'id' ).slice( 10 );
						if ( main_id == sub_id ) {
							parent = $( this );
							return;
						}
					} );
					//$( this ).width( parent.outerWidth()-20 );
					$( this ).css( 'left', parent.position().left + 'px' );
				} );
			}

			// Set sub menu Height
			function setSubMenuHeight() {
				var height = 0;
				$( '.sub-menu ul' ).each( function() {
					var this_height = $( this ).outerHeight( true );
					//console.log(this_height);
					if ( this_height > height )	height = this_height;
				} );
				$( '.sub-menu, .sub-menu ul' ).css( 'height', height );
			}

			setSubMenuPosition();
			$( window ).on( 'resize', function() {
				setSubMenuPosition();
			} );

			// Set sub menu display style
			$( '.site-navigation' ).hover(
				function() {
					$( '.sub-menu' ).css( 'display', 'block' );
					setSubMenuHeight();
				},
				function() {
					$( '.sub-menu' ).css( 'display', 'none' );
				}
			);

		}

	} );

} )( jQuery );