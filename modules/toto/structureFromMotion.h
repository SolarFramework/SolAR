#ifndef STRUCTUREFROMMOTION_H
#define STRUCTUREFROMMOTION_H
#include <xpcf/component/ConfigurableBase.h>

#include "IStructureFromMotion.h"


namespace SolAR {
namespace MODULES {
namespace SolARModuleColmap {


class StructureFromMotion : public org::bcom::xpcf::ConfigurableBase, virtual public SolAR::api::sfm::IStructureFromMotion
{
public:
    StructureFromMotion();
    ~StructureFromMotion() override;
    void unloadComponent () override;

    org::bcom::xpcf::XPCFErrorCode onConfigured() override;
};



} // namespace SolARModuleColmap
} // namespace MODULES
} // namespace SolAR


template <> struct org::bcom::xpcf::ComponentTraits<SolAR::MODULES::SolARModuleColmap::StructureFromMotion>
{
    static constexpr const char * UUID = "{f5290b11-2f64-4560-9d53-4b266fae71a5}";
    static constexpr const char * NAME = "StructureFromMotion";
    static constexpr const char * DESCRIPTION = "StructureFromMotion implements SolAR::api::sfm::IStructureFromMotion interface";
};

#endif // STRUCTUREFROMMOTION_H
