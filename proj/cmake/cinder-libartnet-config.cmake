if ( NOT TARGET Cinder-LibArtnet )
	get_filename_component( CINDER_LIBARTNET_PATH
		"${CMAKE_CURRENT_LIST_DIR}/../../" ABSOLUTE )
	get_filename_component( LIBARTNET_PATH
		"${CMAKE_CURRENT_LIST_DIR}/../../lib/artnet/" ABSOLUTE )

	get_filename_component( CINDER_PATH "${CMAKE_CURRENT_LIST_DIR}/../../../.." ABSOLUTE )

	list( APPEND CINDER_LIBARTNET_SOURCES
		${CINDER_LIBARTNET_PATH}/src/CinderLibArtnet.cpp
	)
	list( APPEND CINDER_LIBARTNET_INCLUDES
		${CINDER_LIBARTNET_PATH}/src
	)

	list( APPEND LIBARTNET_INCLUDES
		${LIBARTNET_PATH}
		${CINDER_LIBARTNET_PATH}/lib
	)

	list( APPEND LIBARTNET_SOURCES
		${LIBARTNET_PATH}/artnet.c
		${LIBARTNET_PATH}/misc.c
		${LIBARTNET_PATH}/network.c
		${LIBARTNET_PATH}/receive.c
		${LIBARTNET_PATH}/tod.c
		${LIBARTNET_PATH}/transmit.c
	)

	add_library( Cinder-LibArtnet ${LIBARTNET_SOURCES} ${CINDER_LIBARTNET_SOURCES})

	target_include_directories( Cinder-LibArtnet PUBLIC ${LIBARTNET_INCLUDES} ${CINDER_LIBARTNET_INCLUDES} )
	target_include_directories( Cinder-LibArtnet PRIVATE BEFORE "${CINDER_PATH}/include" )

	if ( NOT TARGET cinder )
		include( "${CINDER_PATH}/proj/cmake/configure.cmake" )
		find_package( cinder REQUIRED PATHS
			"${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
			"$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}" )
	endif()
	target_link_libraries( Cinder-LibArtnet PRIVATE cinder )

endif()
