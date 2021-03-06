# Copyright: (C) 2010 RobotCub Consortium
# Authors: Lorenzo Natale
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

yarp_prepare_plugin(esdsniffer
    CATEGORY device
    TYPE yarp::dev::EsdMessageSniffer
    INCLUDE EsdMessageSniffer.h 
    EXTRA_CONFIG WRAPPER="")

IF(NOT SKIP_esdsniffer)


  FIND_PACKAGE(ESDCANAPI)
  
  IF(NOT ESDCANAPI_FOUND)
    MESSAGE(SEND_ERROR "esdSniffer: cannot find esdcan api, turn off device")
  ELSE(NOT ESDCANAPI_FOUND)
    INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR} ${ESDCANAPI_INC_DIRS})
    yarp_add_plugin(esdsniffer EsdMessageSniffer.cpp EsdMessageSniffer.h)
    TARGET_LINK_LIBRARIES(esdsniffer  ${ESDCANAPI_LIB} ${YARP_LIBRARIES})
    icub_export_plugin(esdsniffer)
    yarp_install(FILES esdsniffer.ini  DESTINATION ${ICUB_PLUGIN_MANIFESTS_INSTALL_DIR})
  ENDIF(NOT ESDCANAPI_FOUND)

ENDIF(NOT SKIP_esdsniffer)
