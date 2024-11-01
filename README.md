Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Yifan Lu
  * [LinkedIn](https://www.linkedin.com/in/yifan-lu-495559231/), [personal website](http://portfolio.samielouse.icu/index.php/category/featured/)
* Tested on: Windows 11, AMD Ryzen 7 5800H 3.20 GHz, Nvidia GeForce RTX 3060 Laptop GPU (Personal Laptop)

![](img/cover.gif)

### Feature
- Real-time rendering of grass blades with lambert shading
- Three distinct culling tests: orientation, view-frustum, and distance culling
- Tessellation shader to transform Bezier curves into grass blade geometry

### Introduction
This project is an implementation of the paper, [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf).

This project presents a Vulkan-based grass simulator and renderer using compute shaders for efficient, realistic grass animation. Each grass blade is represented as a Bezier curve, with physics calculations applied to simulate natural movements influenced by gravity, wind, and recovery forces. Grass blades are dynamically culled to improve performance, removing those outside the frame or that won’t contribute meaningfully to the scene. The rendering pipeline includes a vertex shader for transforming Bezier control points, tessellation shaders to generate grass geometry, and a fragment shader for shading the blades. 

### Grass Animation
The grass blades' animation is griven by three forces: 
- wind force
- recovery
- gravity

The forces are applied to the "guid point" v2:

<p float="center">
  <img src="https://github.com/user-attachments/assets/0829f754-21f3-4bba-b343-39360392326e" width="25%" />
</p>

A comparison of applying force before and after:
<p float="center">
  <img src="https://github.com/user-attachments/assets/62c07c7c-34f0-491b-ada9-2ff98e4c32f6" width="25%" />
  <img src="https://github.com/user-attachments/assets/df4a1b9b-4f75-4572-8df5-95e4cbf60bcd" width="25%" />
</p>


### Culling
In this grass simulation project, three culling methods are employed to optimize performance by omitting grass blades that won’t significantly impact the final render:

- Orientation Culling:

 Grass blades whose front faces are perpendicular to the camera view are removed, as they would appear thinner than a pixel and cause aliasing artifacts. This is determined by comparing the dot product of the view vector and the blade’s front face direction.

- View-Frustum Culling:

Blades outside the camera’s view are discarded. This is determined by checking three key points along each Bezier curve (v0, v2, and an approximated midpoint) to ensure the blade is within the view-frustum. If all points fall outside, the blade is culled.

- Distance Culling:

Blades that are too far from the camera to be visually impactful are culled. The scene is divided into distance-based "buckets" with blades progressively culled in each bucket as they are farther from the camera, allowing for a controlled fade-out of distant grass blades.

The following three gifs show the Orientation Culling, View-Frustum Culling and Distance Culling respectively.

<p float="center">
  <img src="/img/orientation.gif" width="25%" />
  <img src="/img/view.gif" width="25%" />
  <img src="/img/distance.gif" width="25%" />
</p>


### Performance Analysis
I added a fps counter to the main loop. The following graph shows the fps change with different culling methods:
 
<p float="center">
  <img src="https://github.com/user-attachments/assets/1f826aaf-f137-417d-bbc0-d81e5e099215" width="45%" />
</p>

The following chart illustrates the average frames per second (FPS) at different tessellation levels with a default camera angle in a grass simulation project. As the tessellation level increases, FPS decreases, reflecting the higher computational load. At lower tessellation levels (2 to 16), FPS remains high, with a peak of 3210 FPS at level 2, gradually decreasing to 2339 FPS at level 16. Beyond level 32, FPS drops sharply, stabilizing around 260 FPS from level 64 onward, indicating that increasing tessellation beyond this point has minimal impact on visual fidelity but significantly affects performance.

<p float="center">
  <img src="https://github.com/user-attachments/assets/81c91b8e-a1cf-44b5-8c98-efc3ae17a468" width="45%" />
</p>

