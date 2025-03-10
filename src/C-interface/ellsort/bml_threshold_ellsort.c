#include "../bml_logger.h"
#include "../bml_threshold.h"
#include "../bml_types.h"
#include "bml_threshold_ellsort.h"
#include "bml_types_ellsort.h"

#include <stdlib.h>
#include <string.h>

/** Threshold a matrix.
 *
 *  \ingroup threshold_group
 *
 *  \param A The matrix to be thresholded
 *  \param threshold Threshold value
 *  \return the thresholded A
 */
bml_matrix_ellsort_t
    * bml_threshold_new_ellsort(bml_matrix_ellsort_t * A, double threshold)
{
    bml_matrix_ellsort_t *B = NULL;

    switch (A->matrix_precision)
    {
        case single_real:
            B = bml_threshold_new_ellsort_single_real(A, threshold);
            break;
        case double_real:
            B = bml_threshold_new_ellsort_double_real(A, threshold);
            break;
#ifdef BML_COMPLEX
        case single_complex:
            B = bml_threshold_new_ellsort_single_complex(A, threshold);
            break;
        case double_complex:
            B = bml_threshold_new_ellsort_double_complex(A, threshold);
            break;
#endif
        default:
            LOG_ERROR("unknown precision\n");
            break;
    }
    return B;
}

/** Threshold a matrix in place.
 *
 *  \ingroup threshold_group
 *
 *  \param A The matrix to be thresholded
 *  \param threshold Threshold value
 *  \return the thresholded A
 */
void
bml_threshold_ellsort(
    bml_matrix_ellsort_t * A,
    double threshold)
{

    switch (A->matrix_precision)
    {
        case single_real:
            bml_threshold_ellsort_single_real(A, threshold);
            break;
        case double_real:
            bml_threshold_ellsort_double_real(A, threshold);
            break;
#ifdef BML_COMPLEX
        case single_complex:
            bml_threshold_ellsort_single_complex(A, threshold);
            break;
        case double_complex:
            bml_threshold_ellsort_double_complex(A, threshold);
            break;
#endif
        default:
            LOG_ERROR("unknown precision\n");
            break;
    }
}
