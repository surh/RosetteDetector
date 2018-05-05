context("Geometry")

test_that("adjust_rectangle",{
  expect_equal(adjust_rectangle(points = list(topright = c(m.cx = 1, m.cy = 1),
                                              topleft = c(m.cx = 0, m.cy = 1),
                                              bottomright = c(m.cx = 1, m.cy = 0),
                                              bottomleft = c(m.cx = 0, m.cy = 0)),
                                v = 1),
               list(topright = c(m.cx = 1, m.cy = 2),
                    topleft = c(m.cx = 0, m.cy = 2),
                    bottomright = c(m.cx = 1, m.cy = -1),
                    bottomleft = c(m.cx = 0, m.cy = -1)))
  expect_equal(adjust_rectangle(points = list(topright = c(m.cx = 1, m.cy = 1),
                                              topleft = c(m.cx = 0, m.cy = 1),
                                              bottomright = c(m.cx = 1, m.cy = 0),
                                              bottomleft = c(m.cx = 0, m.cy = 0)),
                                h = 1),
               list(topright = c(m.cx = 2, m.cy = 1),
                    topleft = c(m.cx = -1, m.cy = 1),
                    bottomright = c(m.cx = 2, m.cy = 0),
                    bottomleft = c(m.cx = -1, m.cy = 0)))
  expect_equal(adjust_rectangle(points = list(topright = c(m.cx = 1, m.cy = 0.5),
                                              topleft = c(m.cx = 0.5, m.cy = 1),
                                              bottomright = c(m.cx = 0.5, m.cy = 0),
                                              bottomleft = c(m.cx = 0, m.cy = 0.5)),
                                h = 1),
               list(topright = c(m.cx = 1 + sqrt(2*(0.5^2)), m.cy = 0.5 - sqrt(2*(0.5^2))),
                    topleft = c(m.cx = 0.5 - sqrt(2*(0.5^2)), m.cy = 1 + sqrt(2*(0.5^2))),
                    bottomright = c(m.cx = 0.5 + sqrt(2*(0.5^2)), m.cy = 0 - sqrt(2*(0.5^2))),
                    bottomleft = c(m.cx = 0 - sqrt(2*(0.5^2)), m.cy = 0.5 + sqrt(2*(0.5^2)))))
})



# a <- do.call(rbind,list(topright = c(m.cx = 1, m.cy = 0.5),
#      topleft = c(m.cx = 0.5, m.cy = 1),
#      bottomright = c(m.cx = 0.5, m.cy = 0),
#      bottomleft = c(m.cx = 0, m.cy = 0.5)))
# a
# plot(a[,1],a[,2])
# 
# b <- adjust_rectangle(points = list(topright = c(m.cx = 1, m.cy = 0.5),
#                                topleft = c(m.cx = 0.5, m.cy = 1),
#                                bottomright = c(m.cx = 0.5, m.cy = 0),
#                                bottomleft = c(m.cx = 0, m.cy = 0.5)),
#                  h = 1)
# b <- do.call(rbind,b)
# plot(b[,1],b[,2])
# points(a[,1],a[,2],pch = 19)

# 
# list(topright = c(m.cx = 1, m.cy = 1),
#      topleft = c(m.cx = 0, m.cy = 1),
#      bottomright = c(m.cx = 1, m.cy = 0),
#      bottomleft = c(m.cx = 0, m.cy = 0))


