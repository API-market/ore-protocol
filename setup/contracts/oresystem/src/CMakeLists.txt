project(oresystem)

set(EOSIO_WASM_OLD_BEHAVIOR "Off")
find_package(eosio.cdt)

add_contract( oresystem oresystem oresystem.cpp )
target_include_directories( oresystem PUBLIC ${CMAKE_SOURCE_DIR}/../include )
target_ricardian_directory( oresystem ${CMAKE_SOURCE_DIR}/../ricardian )
