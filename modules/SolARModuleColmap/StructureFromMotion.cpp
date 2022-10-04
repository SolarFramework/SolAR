#include "StructureFromMotion.h"

namespace xpcf = org::bcom::xpcf;

template<> SolAR::MODULES::SolARModuleColmap::StructureFromMotion * xpcf::ComponentFactory::createInstance<SolAR::MODULES::SolARModuleColmap::StructureFromMotion>();


namespace SolAR {
namespace MODULES {
namespace SolARModuleColmap {


StructureFromMotion::StructureFromMotion():xpcf::ConfigurableBase(xpcf::toMap<StructureFromMotion>())
{
    declareInterface<SolAR::api::sfm::IStructureFromMotion>(this);
    //  Inject declarations come here : declare any component that must be injected to your component through its interface /////////////////////////..///// declareInjectable<IFilter>(m_filter);
    //
    // Inject declaration can have a name :
    // declareInjectable<IFilter>(m_blurFilter, "blurFilter");
    //
    // Inject declaration can be optional i.e. not finding a binding component for the interface is not an error :
    // declareInjectable<IImageFilter>(m_imageFilter, false);
    declareInjectable<IPointCloudManager>(m_pointCloudManager);
    declareInjectable<IKeyframesManager>(m_keyframesManager);
    // wrap any component member variable to expose as properties with declareProperty<T>() with T matching the variable type
    // For example : declareProperty<float>("blurFactor",m_blurFactor);
    // declareProperty("name",m_memberVariable) also works with template type deduction when m_memberVariable is a supported type of IProperty
    declareProperty("imagePath", m_imagePath);
}


StructureFromMotion::~StructureFromMotion()
{

}

void StructureFromMotion::unloadComponent ()
{
    // provide component cleanup strategy
    // default strategy is to delete self, uncomment following line in this case :
    // delete this;
    return;
}

xpcf::XPCFErrorCode StructureFromMotion::onConfigured()
{
    // Add custom onConfigured code
    //
    return xpcf::XPCFErrorCode::_SUCCESS;
}

FrameworkReturnCode StructureFromMotion::createMap(std::vector<SRef<datastructure::CloudPoint>> map)
{
    return FrameworkReturnCode::_SUCCESS;
}

} // namespace SolARModuleColmap
} // namespace MODULES
} // namespace SolAR
