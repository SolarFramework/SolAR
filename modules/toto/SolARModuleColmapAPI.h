#ifndef SolARModuleColmapAPI_H
#define SolARModuleColmapAPI_H

#if _WIN32
#ifdef SolARModuleColmap_API_DLLEXPORT
#define SolARModuleColmap_EXPORT_API __declspec(dllexport)
#else
#define SolARModuleColmap_EXPORT_API __declspec(dllimport)
#endif
#else //!_WIN32
#define SolARModuleColmap_EXPORT_API
#endif //!_WIN32

#endif // XPCFSAMPLECOMPONENTAPI_H
