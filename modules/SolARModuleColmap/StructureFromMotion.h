#ifndef STRUCTUREFROMMOTION_H
#define STRUCTUREFROMMOTION_H
#include "xpcf/component/ConfigurableBase.h"
#include "api/sfm/IStructureFromMotion.h"
#include "SolARModuleColmapAPI.h"
#include "api/storage/IPointCloudManager"
#include "api/storage/IKeyframesManager"


namespace SolAR {
namespace MODULES {
namespace SolARModuleColmap {


class SolARModuleColmap_EXPORT_API StructureFromMotion : public org::bcom::xpcf::ConfigurableBase, virtual public SolAR::api::sfm::IStructureFromMotion
{
public:
    StructureFromMotion();
    ~StructureFromMotion() override;
    void unloadComponent () override;

    org::bcom::xpcf::XPCFErrorCode onConfigured() override;

    /// @brief Create map
    /// @param[in] keyframe: the keyframe to add to the bag of words
    /// @return FrameworkReturnCode::_SUCCESS if the keyfram adding succeed, else FrameworkReturnCode::_ERROR_
    FrameworkReturnCode createMap(std::vector<SRef<datastructure::CloudPoint>> map) override;

private:
    //SRef<datastructure::Identification>		m_identification;
    //SRef<datastructure::CoordinateSystem>	m_coordinateSystem;
    SRef<api::storage::IPointCloudManager>	m_pointCloudManager;
    SRef<api::storage::IKeyframesManager>	m_keyframesManager;
    //SRef<api::storage::ICovisibilityGraph>	m_covisibilityGraph;
    //SRef<api::reloc::IKeyframeRetriever>	m_keyframeRetriever;
    mutable std::mutex                      m_mutex;

    std::string m_imagePath;
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
