# Lazy_snapping_and-Poission_Image_editing
<h2>Lazy Snapping</h2>
Extract the foreground object from original image using Graph cut

<h2>Graph Cut Algorithm</h2>
<p>Graph Cut is graph-based segmentation. Each pixel is a node in a graph and link each node to its four neighbors. The graph has two additional nodes: source and terminal. Each node is connected to both the source and terminal. Calculate the data cost and smooth cost at nodes and edges to break graph into segments.</p>
<p>The GC_optimization for energy minimization with graph cuts: <a href="http://www.csd.uwo.ca/~olga/OldCode.html">GCMex</a>
</p>
<p>
1. Data cost: </br>
Extract the marked foreground and background pixels as sample.</br>
A Gaussian mixture model is a probabilistic model that assumes all the data points are generated from a mixture of a finite number of Gaussian distributions with unknown parameters. Use Gaussian Mixture model to fit foreground and background samples.</br>
Use probability density function (pdf) to calculate the probability of the all pixels belonging to foreground and background.</br>
2. Smooth cost:</br>
Use color sparse matrix of a graph to measure the neighbors ‘similarity. When colors are similar, the smooth cost is larger, when colors are different, the smooth cost is smaller.</br>
3. Fit GCMex graph cut model</p>

<h2>Poission Image Editing Algorithm</h2>
Poisson Image Editing is that given a source image, a target image and a "mask" image to paste gradient from the source image into the target image

<p>The image blending problem is considered as a least-squares problem, which requires solving Ax = b for every pixel under the mask.</br>
The mask contains the same size with both the source and target images. In the final blending result, if the mask's value is 0, just take the target's pixel value at that pixel. If it is 1, set up a linear equation such that the gradient for a given pixel is the same in both the source and final images. Construct the equation:</br>
<p align="center">4*source_pixel - Up - Down - Right -Left = gradient</p>
</p>

<h2>Result</h2>
<p align="center">Graph Cut Result</P>
<img src= "https://github.com/Joey2793/Lazy_snapping_and-Poission_Image_editing/blob/master/data/result/DOG.jpg"/>
<p align="center">Possion Editing Result</P>
<p align="center"><img src= "https://github.com/Joey2793/Lazy_snapping_and-Poission_Image_editing/blob/master/data/result/data1.jpg"/></p>
