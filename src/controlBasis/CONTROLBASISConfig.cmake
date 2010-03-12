IF(NOT CONTROLBASIS_FOUND)
    MESSAGE(STATUS "Using CONTROLBASISConfig.cmake")
    
    SET(LIB_DIR ${CONTROLBASIS_DIR})
    SET(CONTROLBASIS_INCLUDE_DIRS 
      ${LIB_DIR}/include
      ${LIB_DIR}/resources
      ${LIB_DIR}/jacobians
      ${LIB_DIR}/potentialFunctions
      ${LIB_DIR}/control
      )
    
    IF(NESTED_BUILD)
        SET(CONTROLBASIS_LIBRARIES controlBasis)
    ELSE(NESTED_BUILD)
        FIND_LIBRARY(CONTROLBASIS_LIBRARIES controlBasis ${ICUB_DIR}/lib ${LIB_DIR})  
        IF(NOT CONTROLBASIS_LIBRARIES)
            FIND_LIBRARY(CONTROLBASIS_LIBRARIES_RELEASE controlBasis 
    		         ${ICUB_DIR}/lib/Release ${LIB_DIR}/Release NO_DEFAULT_PATH)
            FIND_LIBRARY(CONTROLBASIS_LIBRARIES_DEBUG controlBasis 
    		         ${ICUB_DIR}/lib/Debug ${LIB_DIR}/Debug NO_DEFAULT_PATH)
    
            IF(CONTROLBASIS_LIBRARIES_RELEASE AND NOT CONTROLBASIS_LIBRARIES_DEBUG)
                SET(CONTROLBASIS_LIBRARIES_RELEASE ${CONTROLBASIS_LIBRARIES_RELEASE})
                SET(CONTROLBASIS_LIBRARIES ${CONTROLBASIS_LIBRARIES_RELEASE} 
                    CACHE PATH "release version of library" FORCE)
            ENDIF(CONTROLBASIS_LIBRARIES_RELEASE AND NOT CONTROLBASIS_LIBRARIES_DEBUG)
    
            IF(CONTROLBASIS_LIBRARIES_DEBUG AND NOT CONTROLBASIS_LIBRARIES_RELEASE)
                SET(CONTROLBASIS_LIBRARIES_DEBUG ${CONTROLBASIS_LIBRARIES_DEBUG})
                SET(CONTROLBASIS_LIBRARIES ${CONTROLBASIS_LIBRARIES_DEBUG} 
                    CACHE PATH "debug version of library" FORCE)
            ENDIF(CONTROLBASIS_LIBRARIES_DEBUG AND NOT CONTROLBASIS_LIBRARIES_RELEASE)
    
            IF(CONTROLBASIS_LIBRARIES_DEBUG AND CONTROLBASIS_LIBRARIES_RELEASE)
                SET(CONTROLBASIS_LIBRARIES_RELEASE ${CONTROLBASIS_LIBRARIES_RELEASE})
                SET(CONTROLBASIS_LIBRARIES_DEBUG ${CONTROLBASIS_LIBRARIES_DEBUG})
                SET(CONTROLBASIS_LIBRARIES optimized ${CONTROLBASIS_LIBRARIES_RELEASE}
    	            debug ${CONTROLBASIS_LIBRARIES_DEBUG} 
                    CACHE PATH "debug and release version of library" FORCE )
            ENDIF(CONTROLBASIS_LIBRARIES_DEBUG AND CONTROLBASIS_LIBRARIES_RELEASE)
    
            MARK_AS_ADVANCED(CONTROLBASIS_LIBRARIES_RELEASE)
            MARK_AS_ADVANCED(CONTROLBASIS_LIBRARIES_DEBUG)
    
        ENDIF(NOT CONTROLBASIS_LIBRARIES)
    
    ENDIF(NESTED_BUILD)

    # Add YARP dependencies
    FIND_PACKAGE(YARP)
    FIND_PACKAGE(IPOPT REQUIRED)
    FIND_PACKAGE(CTRLLIB REQUIRED)
    FIND_PACKAGE(IKIN REQUIRED)
    FIND_PACKAGE(REINFORCEMENTLEARNING)
    SET(CONTROLBASIS_LIBRARIES ${CONTROLBASIS_LIBRARIES} ${YARP_LIBRARIES} ${REINFORCEMENTLEARNING_LIBRARIES} ${IKIN_LIBRARIES} ${CTRLLIB_LIBRARIES} ${IPOPTLIB_LIBRARIES} )
    
    IF(CONTROLBASIS_INCLUDE_DIRS AND CONTROLBASIS_LIBRARIES)
        SET(CONTROLBASIS_FOUND TRUE)
    ELSE(CONTROLBASIS_INCLUDE_DIRS AND CONTROLBASIS_LIBRARIES)
        SET(CONTROLBASIS_FOUND FALSE)
    ENDIF(CONTROLBASIS_INCLUDE_DIRS AND CONTROLBASIS_LIBRARIES)
    
ENDIF(NOT CONTROLBASIS_FOUND)
