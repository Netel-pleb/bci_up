# BC&#8593;
# Project Roadmap: Integration of Pre-Trial Information in Motor Imagery EEG Decoding

## Introduction
This project aims to explore the potential of integrating pre-trial EEG data to enhance the decoding accuracy of motor imagery tasks in Brain-Computer Interface (BCI) systems. By analyzing structured EEG data and later extending to unstructured data, we will determine whether pre-trial neural activity can provide additional predictive power for decoding motor imagery.

## Goals
- **Primary Objective**: Improve the decoding accuracy of motor imagery tasks by incorporating pre-trial EEG information into the model.
- **Secondary Objective**: Investigate the impact of varying pre-trial periods, including the 1-second window before a trial and longer periods extending up to the previous trial, to assess their influence on decoding performance.
- **Future Work**: Once the structured data is fully analyzed, extend the methods to unstructured, continuous EEG data.

## Research Questions
- Can pre-trial EEG activity improve the decoding accuracy of motor imagery in BCI systems?
- How does the length of pre-trial information (1-second vs. longer periods) impact the model’s predictive capability?
- How can we efficiently process and decode unstructured EEG data for motor imagery tasks?

## Key Objectives
1. **Dataset Selection and Preparation**  
   - Use an EEG dataset with structured trials, focusing on motor imagery tasks (e.g., left/right hand movement).
   - Extract pre-trial data for analysis, specifically for the 1-second period before trial onset and longer periods, including up to the previous trial.

2. **Preprocessing**  
   - Develop preprocessing techniques to clean EEG data, removing EMG and eye blink artifacts while preserving pre-trial information.
   - Compare data quality for the pre-trial and trial periods
   - Use known trial markers to segment and align trials and pre-trial periods for analysis.

3. **Feature Extraction**  
   - Propose and implement a new method for feature extraction that includes both trial and pre-trial EEG data.
   - Analyze time-frequency features and use Long Short-Term Memory (LSTM) or Gated Recurrent Units (GRU) to capture subtle pre-trial patterns.
   - Test multiple lengths of pre-trial information to see if the model performance improves.

4. **Decoding Model**  
   - Implement decoding models that incorporate pre-trial information along with trial data:
     * Support Vector Machines (SVM) with RBF Kernel
     * Denoising Autoencoders (DAE)
     * Random Forests
     * Graph Neural Networks (GNNs)
   - Train the models on structured EEG data and assess the accuracy improvement from pre-trial integration.

5. **Evaluation**  
   - Compare decoding accuracy with and without pre-trial information to quantify the impact of this additional data.
   - Evaluate performance across different pre-trial window lengths (1 second, up to including the previous trial).
   - Benchmark the method against standard motor imagery decoding models.

6. **Unstructured Data Analysis**  
   - **After completing structured data analysis**, transition to working with unstructured continuous EEG data, which lacks specific trial time points.
   - Develop methods to segment relevant periods of the unstructured data using patterns learned from the structured analysis.
   - Test and refine decoding models on unstructured data, ensuring they maintain or improve performance without explicit trial markers.

## Technical Milestones
- **Month 1**: Data selection, segmentation, and preprocessing of structured EEG data.
- **Month 2-3**: Implement pre-trial feature extraction techniques and test model performance.
- **Month 4-5**: Complete decoding model development and performance evaluation on structured data.
- **Month 6**: Transition to unstructured data analysis, develop segmentation methods, and test decoding models.
- **Month 7**: Final evaluation of all results, summary of findings, and preparation for dissemination.

## Challenges and Risks
- Pre-trial information may introduce noise if not carefully extracted and processed.
- Handling unstructured data may present computational challenges and require new algorithms.
- The impact of pre-trial data on accuracy may vary significantly between subjects.

## Resources and Tools
- **Tools**: Python (MNE, scikit-learn, PyTorch), MATLAB for signal processing, and EEG-specific toolboxes.
- **Hardware**: Access to high-performance computing resources for analyzing large unstructured datasets (AWS).

## Future Work
- Explore real-time BCI systems incorporating pre-trial information.
- Test the method on larger, more diverse datasets and in clinical applications, such as stroke rehabilitation or neurofeedback.

Using dataset: http://gigadb.org/dataset/100295  
Cho, H., Ahn, M., Ahn, S., Moonyoung Kwon, & Jun, S. C. (2017). Supporting data for "EEG datasets for motor imagery brain computer interface" [Data set]. GigaScience Database. https://doi.org/10.5524/100295  
This dataset features EEG recordings for Motor Imagery (MI) BCI from 52 participants, along with EMG data, EEG electrode locations, and questionnaire responses. It’s been validated to show key MI patterns (ERD/ERS), and 73% of the data has strong discriminative features. Great for digging into BCI performance variation and understanding what makes some sessions work better than others  
