# K-Nearest Neighbors (K-NN)

# import the dataset
dataset = read.csv("Social_Network_Ads.csv")
# dataset = dataset[3:5]

# encoding the target
dataset$Purchased = factor(dataset$Purchased, levels = c(0, 1))

# splitting the dataset
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# feature scaling
training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])

# fitting classifier to the training set
library(class)
y_pred = knn(train = training_set[, -3],
             test = test_set[, -3],
             cl = training_set[, 3],
             k = 5)

# making the confusion matrix
cm = table(test_set[, 3], y_pred)

# visualizing the training set results
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = .01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = .01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c("Age", "EstimatedSalary")
y_grid = knn(train = training_set[, -3],
             test = grid_set,
             cl = training_set[, 3],
             k = 5)
plot(set[, -3],
     main = "K-NN (Training set)",
     xlab = "Age", ylab = "Estimated Salary",
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = ".", col = ifelse(y_grid == 1, "springgreen3", "tomato"))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, "green4", "red3"))

# visualizing the test set results
library(ElemStatLearn)
set = test_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = .01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = .01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c("Age", "EstimatedSalary")
y_grid = y_grid = knn(train = training_set[, -3],
                      test = grid_set,
                      cl = training_set[, 3],
                      k = 5)
plot(set[, -3],
     main = "K-NN (Test set)",
     xlab = "Age", ylab = "Estimated Salary",
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = ".", col = ifelse(y_grid == 1, "springgreen3", "tomato"))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, "green4", "red3"))