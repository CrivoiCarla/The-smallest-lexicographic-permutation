# The-smallest-lexicographic-permutation
Read from the keyboard n, m and 3 · n elements that can be or 0, or between 1 and n, where the condition 1 ≤ n, m ≤ 30 is observed. The smallest lexicographic permutation of the set will be generated {1, ..., n}, where each element appears exactly 3 times, having a distance of at least m elements between any two equal elements, starting from certain fixed points already specified.
# Example
For n = 5, m = 1 and the sequence of 15 elements  
**1 0 0 0 0 0 3 0 0 0 0 0 0 4 5**  
we have that each element of the set {1, 2, 3, 4, 5} appears 3 times, and we want to be at least m = 1 element distance between any two equal elements.  
Then the slightest permutation in the sense
lexicographically, keeping the fixed points, it is the following:  
**1 2 1 2 1 2 3 4 3 5 3 4 5 4 5**  
Will be displayed at standard output, as appropriate,
• or permutation, if any, in the above format: the elements will be displayed with spaces between them
on the screen, and at the end we recommend to display a backslash character n, instead of using fflush;
• or −1, if there is no permutation that satisfies all conditions.
