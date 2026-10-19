#pragma once

#define WIN32_LEAN_AND_MEAN
#define NOMINMAX

#include <RE/Skyrim.h>
#include <REL/Relocation.h>
#include <SKSE/SKSE.h>

#include <spdlog/sinks/basic_file_sink.h>

#include <algorithm>
#include <array>
#include <atomic>
#include <cstdint>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <memory>
#include <mutex>
#include <optional>
#include <ranges>
#include <span>
#include <string>
#include <string_view>
#include <unordered_map>
#include <unordered_set>
#include <vector>

using namespace std::literals;

namespace logger = SKSE::log;

namespace stl {
    using namespace SKSE::stl;
}
// Compatibility shim preserving the upstream HUD notification API.
namespace RE {
inline void DebugNotification(const char* text, const char* sound = nullptr, bool cancel = true) {
    using Fn = void(const char*, const char*, bool);
    static REL::Relocation<Fn> notify{REL::RelocationID(52050, 52933)};
    notify(text, sound, cancel);
}
}
