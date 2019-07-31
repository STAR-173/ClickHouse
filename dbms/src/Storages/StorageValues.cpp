#include <Storages/IStorage.h>
#include <Storages/StorageValues.h>
#include <DataStreams/OneBlockInputStream.h>


namespace DB
{
/* One block storage used for values table function
 * It's structure is similar to IStorageSystemOneBlock
 */
StorageValues::StorageValues(const std::string & database_name_, const std::string & table_name_, const Block & res_block_)
    : database_name(database_name_), table_name(table_name_), res_block(res_block_)
{
    setColumns(ColumnsDescription(res_block.getNamesAndTypesList()));
}

BlockInputStreams StorageValues::read(
    const Names & column_names,
    const SelectQueryInfo & /*query_info*/,
    const Context & /*context*/,
    QueryProcessingStage::Enum /*processed_stage*/,
    size_t /*max_block_size*/,
    unsigned /*num_streams*/)
{
    check(column_names);

    return BlockInputStreams(1, std::make_shared<OneBlockInputStream>(res_block));
}

}
