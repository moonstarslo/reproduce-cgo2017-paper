; ModuleID = 'src/bfs_m5.c'
source_filename = "src/bfs_m5.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@depth = dso_local local_unnamed_addr global i32 0, align 4, !dbg !0
@queue_start_ptr = dso_local local_unnamed_addr global i32 0, align 4, !dbg !83
@queue_end_ptr = dso_local local_unnamed_addr global i32 1, align 4, !dbg !85
@row = common dso_local global i32 0, align 4, !dbg !87
@start_point = common dso_local local_unnamed_addr global i32 0, align 4, !dbg !100
@out_degree = common dso_local local_unnamed_addr global [10000000 x i32] zeroinitializer, align 4, !dbg !102
@bfs_queue = common dso_local local_unnamed_addr global [10000000 x i32] zeroinitializer, align 4, !dbg !117
@result = common dso_local local_unnamed_addr global [10000000 x i32] zeroinitializer, align 4, !dbg !107
@vis = common dso_local local_unnamed_addr global [10000000 x i8] zeroinitializer, align 1, !dbg !113
@row_ptr = common dso_local local_unnamed_addr global [10000000 x i32] zeroinitializer, align 4, !dbg !111
@col_idx = common dso_local global [10000000 x i32] zeroinitializer, align 4, !dbg !109
@.str.1 = private unnamed_addr constant [22 x i8] c"start point is NO.%d\0A\00", align 1
@.str.2 = private unnamed_addr constant [22 x i8] c"depth for NO.%d = %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.6 = private unnamed_addr constant [16 x i8] c"\E6\96\87\E4\BB\B6\E8\B7\AF\E5\BE\84\E4\B8\BA\00", align 1
@.str.8 = private unnamed_addr constant [7 x i8] c"%d%d%d\00", align 1
@col = common dso_local global i32 0, align 4, !dbg !89
@nnz = common dso_local global i32 0, align 4, !dbg !91
@.str.9 = private unnamed_addr constant [68 x i8] c"\E7\A8\80\E7\96\8F\E7\9F\A9\E9\98\B5\E4\B8\AD\EF\BC\8C\E8\A1\8C\E6\95\B0\E4\B8\BA%d\EF\BC\8C\E5\88\97\E6\95\B0\E4\B8\BA%d\EF\BC\8C\E9\9D\9E\E9\9B\B6\E5\85\83\E7\B4\A0\E5\85\B1\E6\9C\89%d\0A\00", align 1
@.str.10 = private unnamed_addr constant [8 x i8] c"%d%d%lf\00", align 1
@value = common dso_local global [10000000 x double] zeroinitializer, align 8, !dbg !119
@.str.11 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@temp_row = common dso_local local_unnamed_addr global i32 0, align 4, !dbg !93
@temp_column = common dso_local local_unnamed_addr global i32 0, align 4, !dbg !95
@temp_value = common dso_local local_unnamed_addr global double 0.000000e+00, align 8, !dbg !97
@cache_flush = common dso_local local_unnamed_addr global [1048576 x double] zeroinitializer, align 8, !dbg !122
@str = private unnamed_addr constant [23 x i8] c"Error in loading data.\00", align 1
@str.13 = private unnamed_addr constant [14 x i8] c"BFS begining!\00", align 1
@str.14 = private unnamed_addr constant [14 x i8] c"BFS finished!\00", align 1
@str.15 = private unnamed_addr constant [19 x i8] c"null file pointer!\00", align 1

; Function Attrs: noreturn nounwind
define dso_local void @handle_error() local_unnamed_addr #0 !dbg !131 {
  %1 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([23 x i8], [23 x i8]* @str, i64 0, i64 0)), !dbg !134
  tail call void @exit(i32 0) #12, !dbg !135
  unreachable, !dbg !135
}

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) local_unnamed_addr #2

; Function Attrs: nounwind
define dso_local void @generate_start_point() local_unnamed_addr #3 !dbg !136 {
  call void @llvm.dbg.value(metadata i32 0, metadata !138, metadata !DIExpression()), !dbg !139
  br label %1, !dbg !140

1:                                                ; preds = %1, %0
  %2 = phi i32 [ 0, %0 ], [ %6, %1 ], !dbg !139
  call void @llvm.dbg.value(metadata i32 %2, metadata !138, metadata !DIExpression()), !dbg !139
  %3 = tail call i32 @rand() #13, !dbg !141
  %4 = load i32, i32* @row, align 4, !dbg !143, !tbaa !144
  %5 = srem i32 %3, %4, !dbg !148
  store i32 %5, i32* @start_point, align 4, !dbg !149, !tbaa !144
  %6 = add nuw nsw i32 %2, 1, !dbg !150
  call void @llvm.dbg.value(metadata i32 %6, metadata !138, metadata !DIExpression()), !dbg !139
  %7 = sext i32 %5 to i64, !dbg !151
  %8 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @out_degree, i64 0, i64 %7, !dbg !151
  %9 = load i32, i32* %8, align 4, !dbg !151, !tbaa !144
  %10 = icmp slt i32 %9, 6, !dbg !152
  %11 = icmp ult i32 %2, 100000, !dbg !153
  %12 = and i1 %11, %10, !dbg !153
  br i1 %12, label %1, label %13, !dbg !154, !llvm.loop !155

13:                                               ; preds = %1
  store i32 %5, i32* getelementptr inbounds ([10000000 x i32], [10000000 x i32]* @bfs_queue, i64 0, i64 0), align 4, !dbg !157, !tbaa !144
  %14 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @result, i64 0, i64 %7, !dbg !158
  store i32 0, i32* %14, align 4, !dbg !159, !tbaa !144
  %15 = getelementptr inbounds [10000000 x i8], [10000000 x i8]* @vis, i64 0, i64 %7, !dbg !160
  store i8 1, i8* %15, align 1, !dbg !161, !tbaa !162
  store i32 0, i32* @queue_start_ptr, align 4, !dbg !164, !tbaa !144
  store i32 1, i32* @queue_end_ptr, align 4, !dbg !165, !tbaa !144
  ret void, !dbg !166
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: nounwind
declare !dbg !6 dso_local i32 @rand() local_unnamed_addr #5

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: nofree norecurse nounwind
define dso_local void @BFS_kernel(i32 %0) local_unnamed_addr #6 !dbg !167 {
  call void @llvm.dbg.value(metadata i32 undef, metadata !171, metadata !DIExpression()), !dbg !175
  %2 = load i32, i32* @queue_start_ptr, align 4, !dbg !176, !tbaa !144
  %3 = load i32, i32* @queue_end_ptr, align 4, !dbg !177, !tbaa !144
  %4 = icmp slt i32 %2, %3, !dbg !178
  br i1 %4, label %5, label %56, !dbg !179

5:                                                ; preds = %1
  %6 = sext i32 %2 to i64, !dbg !179
  br label %7, !dbg !179

7:                                                ; preds = %5, %22
  %8 = phi i32 [ %3, %5 ], [ %23, %22 ]
  %9 = phi i64 [ %6, %5 ], [ %24, %22 ]
  %10 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @bfs_queue, i64 0, i64 %9, !dbg !180
  %11 = load i32, i32* %10, align 4, !dbg !180, !tbaa !144
  %12 = sext i32 %11 to i64, !dbg !181
  %13 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %12, !dbg !181
  %14 = load i32, i32* %13, align 4, !dbg !181, !tbaa !144
  call void @llvm.dbg.value(metadata i32 %14, metadata !172, metadata !DIExpression()), !dbg !182
  %15 = add nsw i32 %11, 1, !dbg !183
  %16 = sext i32 %15 to i64, !dbg !185
  %17 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %16, !dbg !185
  %18 = load i32, i32* %17, align 4, !dbg !185, !tbaa !144
  %19 = icmp slt i32 %14, %18, !dbg !186
  br i1 %19, label %20, label %22, !dbg !187

20:                                               ; preds = %7
  %21 = sext i32 %14 to i64, !dbg !187
  br label %27, !dbg !187

22:                                               ; preds = %43, %7
  %23 = phi i32 [ %8, %7 ], [ %44, %43 ], !dbg !177
  %24 = add nsw i64 %9, 1, !dbg !188
  %25 = sext i32 %23 to i64, !dbg !178
  %26 = icmp slt i64 %24, %25, !dbg !178
  br i1 %26, label %7, label %54, !dbg !179, !llvm.loop !189

27:                                               ; preds = %20, %43
  %28 = phi i32 [ %8, %20 ], [ %44, %43 ]
  %29 = phi i32 [ %11, %20 ], [ %45, %43 ]
  %30 = phi i32 [ %8, %20 ], [ %46, %43 ]
  %31 = phi i64 [ %21, %20 ], [ %47, %43 ]
  call void @llvm.dbg.value(metadata i64 %31, metadata !172, metadata !DIExpression()), !dbg !182
  %32 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @col_idx, i64 0, i64 %31, !dbg !191
  %33 = load i32, i32* %32, align 4, !dbg !191, !tbaa !144
  %34 = sext i32 %33 to i64, !dbg !194
  %35 = getelementptr inbounds [10000000 x i8], [10000000 x i8]* @vis, i64 0, i64 %34, !dbg !194
  %36 = load i8, i8* %35, align 1, !dbg !194, !tbaa !162, !range !195
  %37 = icmp eq i8 %36, 0, !dbg !194
  br i1 %37, label %38, label %43, !dbg !196

38:                                               ; preds = %27
  %39 = add nsw i32 %30, 1, !dbg !197
  store i32 %39, i32* @queue_end_ptr, align 4, !dbg !197, !tbaa !144
  %40 = sext i32 %30 to i64, !dbg !199
  %41 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @bfs_queue, i64 0, i64 %40, !dbg !199
  store i32 %33, i32* %41, align 4, !dbg !200, !tbaa !144
  store i8 1, i8* %35, align 1, !dbg !201, !tbaa !162
  %42 = load i32, i32* %10, align 4, !dbg !202, !tbaa !144
  br label %43, !dbg !203

43:                                               ; preds = %27, %38
  %44 = phi i32 [ %28, %27 ], [ %39, %38 ]
  %45 = phi i32 [ %29, %27 ], [ %42, %38 ], !dbg !202
  %46 = phi i32 [ %30, %27 ], [ %39, %38 ]
  %47 = add nsw i64 %31, 1, !dbg !204
  call void @llvm.dbg.value(metadata i64 %47, metadata !172, metadata !DIExpression()), !dbg !182
  %48 = add nsw i32 %45, 1, !dbg !183
  %49 = sext i32 %48 to i64, !dbg !185
  %50 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %49, !dbg !185
  %51 = load i32, i32* %50, align 4, !dbg !185, !tbaa !144
  %52 = sext i32 %51 to i64, !dbg !186
  %53 = icmp slt i64 %47, %52, !dbg !186
  br i1 %53, label %27, label %22, !dbg !187, !llvm.loop !205

54:                                               ; preds = %22
  %55 = trunc i64 %24 to i32, !dbg !188
  store i32 %55, i32* @queue_start_ptr, align 4, !dbg !188, !tbaa !144
  br label %56, !dbg !179

56:                                               ; preds = %54, %1
  ret void, !dbg !207
}

; Function Attrs: nofree nounwind
define dso_local void @print_BFS() local_unnamed_addr #7 !dbg !208 {
  %1 = load i32, i32* @start_point, align 4, !dbg !212, !tbaa !144
  %2 = add nsw i32 %1, 1, !dbg !213
  %3 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([22 x i8], [22 x i8]* @.str.1, i64 0, i64 0), i32 %2), !dbg !214
  call void @llvm.dbg.value(metadata i32 0, metadata !210, metadata !DIExpression()), !dbg !215
  %4 = load i32, i32* @row, align 4, !dbg !216, !tbaa !144
  %5 = icmp sgt i32 %4, 0, !dbg !218
  br i1 %5, label %7, label %6, !dbg !219

6:                                                ; preds = %7, %0
  ret void, !dbg !220

7:                                                ; preds = %0, %7
  %8 = phi i64 [ %9, %7 ], [ 0, %0 ]
  call void @llvm.dbg.value(metadata i64 %8, metadata !210, metadata !DIExpression()), !dbg !215
  %9 = add nuw nsw i64 %8, 1, !dbg !221
  %10 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @result, i64 0, i64 %8, !dbg !223
  %11 = load i32, i32* %10, align 4, !dbg !223, !tbaa !144
  %12 = trunc i64 %9 to i32, !dbg !224
  %13 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([22 x i8], [22 x i8]* @.str.2, i64 0, i64 0), i32 %12, i32 %11), !dbg !224
  call void @llvm.dbg.value(metadata i64 %9, metadata !210, metadata !DIExpression()), !dbg !215
  %14 = load i32, i32* @row, align 4, !dbg !216, !tbaa !144
  %15 = sext i32 %14 to i64, !dbg !218
  %16 = icmp slt i64 %9, %15, !dbg !218
  br i1 %16, label %7, label %6, !dbg !219, !llvm.loop !225
}

; Function Attrs: nounwind
define dso_local i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr #3 !dbg !227 {
  %3 = alloca i32, align 4
  call void @llvm.dbg.value(metadata i32 %0, metadata !232, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i8** %1, metadata !233, metadata !DIExpression()), !dbg !252
  %4 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([14 x i8], [14 x i8]* @str.13, i64 0, i64 0)), !dbg !253
  %5 = getelementptr inbounds i8*, i8** %1, i64 2, !dbg !254
  %6 = load i8*, i8** %5, align 8, !dbg !254, !tbaa !255
  %7 = tail call %struct._IO_FILE* @fopen(i8* %6, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0)), !dbg !257
  call void @llvm.dbg.value(metadata %struct._IO_FILE* %7, metadata !234, metadata !DIExpression()), !dbg !252
  %8 = icmp eq %struct._IO_FILE* %7, null, !dbg !258
  br i1 %8, label %9, label %11, !dbg !260

9:                                                ; preds = %2
  %10 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @str.15, i64 0, i64 0)), !dbg !261
  tail call void @exit(i32 0) #12, !dbg !263
  unreachable, !dbg !263

11:                                               ; preds = %2
  %12 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i64 0, i64 0)), !dbg !264
  %13 = load i8*, i8** %5, align 8, !dbg !266, !tbaa !255
  %14 = tail call i32 @puts(i8* nonnull dereferenceable(1) %13), !dbg !267
  %15 = tail call i32 (%struct._IO_FILE*, i8*, ...) @__isoc99_fscanf(%struct._IO_FILE* nonnull %7, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.8, i64 0, i64 0), i32* nonnull @row, i32* nonnull @col, i32* nonnull @nnz) #13, !dbg !268
  %16 = load i32, i32* @row, align 4, !dbg !269, !tbaa !144
  %17 = load i32, i32* @col, align 4, !dbg !270, !tbaa !144
  %18 = load i32, i32* @nnz, align 4, !dbg !271, !tbaa !144
  %19 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([68 x i8], [68 x i8]* @.str.9, i64 0, i64 0), i32 %16, i32 %17, i32 %18), !dbg !272
  call void @llvm.dbg.value(metadata i32 0, metadata !238, metadata !DIExpression()), !dbg !273
  %20 = load i32, i32* @nnz, align 4, !dbg !274, !tbaa !144
  %21 = icmp sgt i32 %20, 0, !dbg !275
  br i1 %21, label %22, label %24, !dbg !276

22:                                               ; preds = %11
  %23 = bitcast i32* %3 to i8*, !dbg !277
  br label %32, !dbg !276

24:                                               ; preds = %32, %11
  call void @llvm.dbg.value(metadata i32 0, metadata !243, metadata !DIExpression()), !dbg !278
  %25 = load i32, i32* @row, align 4, !dbg !279, !tbaa !144
  %26 = icmp sgt i32 %25, 0, !dbg !281
  br i1 %26, label %27, label %53, !dbg !282

27:                                               ; preds = %24
  %28 = zext i32 %25 to i64, !dbg !282
  %29 = zext i32 %25 to i64, !dbg !282
  %30 = shl nuw nsw i64 %29, 2, !dbg !282
  call void @llvm.memset.p0i8.i64(i8* align 4 bitcast ([10000000 x i32]* @result to i8*), i8 -1, i64 %30, i1 false), !dbg !283
  call void @llvm.memset.p0i8.i64(i8* align 1 getelementptr inbounds ([10000000 x i8], [10000000 x i8]* @vis, i64 0, i64 0), i8 0, i64 %29, i1 false), !dbg !285
  %31 = load i32, i32* getelementptr inbounds ([10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 0), align 4, !dbg !286, !tbaa !144
  br label %129, !dbg !282

32:                                               ; preds = %22, %32
  %33 = phi i64 [ 0, %22 ], [ %49, %32 ]
  call void @llvm.dbg.value(metadata i64 %33, metadata !238, metadata !DIExpression()), !dbg !273
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %23) #13, !dbg !287
  %34 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @col_idx, i64 0, i64 %33, !dbg !288
  %35 = getelementptr inbounds [10000000 x double], [10000000 x double]* @value, i64 0, i64 %33, !dbg !289
  call void @llvm.dbg.value(metadata i32* %3, metadata !240, metadata !DIExpression(DW_OP_deref)), !dbg !277
  %36 = call i32 (%struct._IO_FILE*, i8*, ...) @__isoc99_fscanf(%struct._IO_FILE* nonnull %7, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.10, i64 0, i64 0), i32* nonnull %3, i32* nonnull %34, double* nonnull %35) #13, !dbg !290
  %37 = load i32, i32* %34, align 4, !dbg !291, !tbaa !144
  %38 = add nsw i32 %37, -1, !dbg !291
  store i32 %38, i32* %34, align 4, !dbg !291, !tbaa !144
  %39 = load i32, i32* %3, align 4, !dbg !292, !tbaa !144
  call void @llvm.dbg.value(metadata i32 %39, metadata !240, metadata !DIExpression()), !dbg !277
  %40 = add nsw i32 %39, -1, !dbg !292
  call void @llvm.dbg.value(metadata i32 %40, metadata !240, metadata !DIExpression()), !dbg !277
  %41 = sext i32 %39 to i64, !dbg !293
  %42 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %41, !dbg !293
  %43 = load i32, i32* %42, align 4, !dbg !294, !tbaa !144
  %44 = add nsw i32 %43, 1, !dbg !294
  store i32 %44, i32* %42, align 4, !dbg !294, !tbaa !144
  %45 = sext i32 %40 to i64, !dbg !295
  %46 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @out_degree, i64 0, i64 %45, !dbg !295
  %47 = load i32, i32* %46, align 4, !dbg !296, !tbaa !144
  %48 = add nsw i32 %47, 1, !dbg !296
  store i32 %48, i32* %46, align 4, !dbg !296, !tbaa !144
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %23) #13, !dbg !297
  %49 = add nuw nsw i64 %33, 1, !dbg !298
  call void @llvm.dbg.value(metadata i64 %49, metadata !238, metadata !DIExpression()), !dbg !273
  %50 = load i32, i32* @nnz, align 4, !dbg !274, !tbaa !144
  %51 = sext i32 %50 to i64, !dbg !275
  %52 = icmp slt i64 %49, %51, !dbg !275
  br i1 %52, label %32, label %24, !dbg !276, !llvm.loop !299

53:                                               ; preds = %129, %24
  %54 = call i32 @fclose(%struct._IO_FILE* nonnull %7), !dbg !301
  call void @m5_checkpoint(i64 0, i64 0) #13, !dbg !302
  call void @llvm.dbg.value(metadata i32 0, metadata !138, metadata !DIExpression()) #13, !dbg !303
  br label %55, !dbg !305

55:                                               ; preds = %55, %53
  %56 = phi i32 [ 0, %53 ], [ %60, %55 ], !dbg !303
  call void @llvm.dbg.value(metadata i32 %56, metadata !138, metadata !DIExpression()) #13, !dbg !303
  %57 = call i32 @rand() #13, !dbg !306
  %58 = load i32, i32* @row, align 4, !dbg !307, !tbaa !144
  %59 = srem i32 %57, %58, !dbg !308
  store i32 %59, i32* @start_point, align 4, !dbg !309, !tbaa !144
  %60 = add nuw nsw i32 %56, 1, !dbg !310
  call void @llvm.dbg.value(metadata i32 %60, metadata !138, metadata !DIExpression()) #13, !dbg !303
  %61 = sext i32 %59 to i64, !dbg !311
  %62 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @out_degree, i64 0, i64 %61, !dbg !311
  %63 = load i32, i32* %62, align 4, !dbg !311, !tbaa !144
  %64 = icmp slt i32 %63, 6, !dbg !312
  %65 = icmp ult i32 %56, 100000, !dbg !313
  %66 = and i1 %65, %64, !dbg !313
  br i1 %66, label %55, label %67, !dbg !314, !llvm.loop !315

67:                                               ; preds = %55
  store i32 %59, i32* getelementptr inbounds ([10000000 x i32], [10000000 x i32]* @bfs_queue, i64 0, i64 0), align 4, !dbg !317, !tbaa !144
  %68 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @result, i64 0, i64 %61, !dbg !318
  store i32 0, i32* %68, align 4, !dbg !319, !tbaa !144
  %69 = getelementptr inbounds [10000000 x i8], [10000000 x i8]* @vis, i64 0, i64 %61, !dbg !320
  store i8 1, i8* %69, align 1, !dbg !321, !tbaa !162
  store i32 0, i32* @queue_start_ptr, align 4, !dbg !322, !tbaa !144
  store i32 1, i32* @queue_end_ptr, align 4, !dbg !323, !tbaa !144
  %70 = getelementptr inbounds i8*, i8** %1, i64 1, !dbg !324
  %71 = load i8*, i8** %70, align 8, !dbg !324, !tbaa !255
  %72 = call i32 @strcmp(i8* nonnull dereferenceable(1) %71, i8* nonnull dereferenceable(5) getelementptr inbounds ([5 x i8], [5 x i8]* @.str.11, i64 0, i64 0)) #14, !dbg !325
  %73 = icmp eq i32 %72, 0, !dbg !326
  br i1 %73, label %74, label %188, !dbg !327

74:                                               ; preds = %67
  call void @llvm.dbg.value(metadata i32 0, metadata !245, metadata !DIExpression()), !dbg !328
  %75 = icmp sgt i32 %58, 0, !dbg !329
  br i1 %75, label %76, label %137, !dbg !331

76:                                               ; preds = %74
  %77 = zext i32 %58 to i64, !dbg !331
  call void @llvm.dbg.value(metadata i32 undef, metadata !245, metadata !DIExpression()), !dbg !328
  call void @llvm.dbg.value(metadata i32 undef, metadata !171, metadata !DIExpression()), !dbg !332
  br label %78, !dbg !334

78:                                               ; preds = %125, %76
  %79 = phi i32 [ %59, %76 ], [ %127, %125 ], !dbg !335
  %80 = phi i32 [ 1, %76 ], [ %121, %125 ]
  %81 = phi i64 [ 0, %76 ], [ %122, %125 ]
  %82 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @bfs_queue, i64 0, i64 %81, !dbg !335
  %83 = sext i32 %79 to i64, !dbg !336
  %84 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %83, !dbg !336
  %85 = load i32, i32* %84, align 4, !dbg !336, !tbaa !144
  call void @llvm.dbg.value(metadata i32 %85, metadata !172, metadata !DIExpression()), !dbg !337
  %86 = add nsw i32 %79, 1, !dbg !338
  %87 = sext i32 %86 to i64, !dbg !339
  %88 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %87, !dbg !339
  %89 = load i32, i32* %88, align 4, !dbg !339, !tbaa !144
  %90 = icmp slt i32 %85, %89, !dbg !340
  br i1 %90, label %91, label %120, !dbg !341

91:                                               ; preds = %78
  %92 = sext i32 %85 to i64, !dbg !341
  br label %93, !dbg !341

93:                                               ; preds = %109, %91
  %94 = phi i32 [ %80, %91 ], [ %110, %109 ]
  %95 = phi i32 [ %79, %91 ], [ %111, %109 ]
  %96 = phi i32 [ %80, %91 ], [ %112, %109 ]
  %97 = phi i64 [ %92, %91 ], [ %113, %109 ]
  call void @llvm.dbg.value(metadata i64 %97, metadata !172, metadata !DIExpression()), !dbg !337
  %98 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @col_idx, i64 0, i64 %97, !dbg !342
  %99 = load i32, i32* %98, align 4, !dbg !342, !tbaa !144
  %100 = sext i32 %99 to i64, !dbg !343
  %101 = getelementptr inbounds [10000000 x i8], [10000000 x i8]* @vis, i64 0, i64 %100, !dbg !343
  %102 = load i8, i8* %101, align 1, !dbg !343, !tbaa !162, !range !195
  %103 = icmp eq i8 %102, 0, !dbg !343
  br i1 %103, label %104, label %109, !dbg !344

104:                                              ; preds = %93
  %105 = add nsw i32 %96, 1, !dbg !345
  %106 = sext i32 %96 to i64, !dbg !346
  %107 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @bfs_queue, i64 0, i64 %106, !dbg !346
  store i32 %99, i32* %107, align 4, !dbg !347, !tbaa !144
  store i8 1, i8* %101, align 1, !dbg !348, !tbaa !162
  %108 = load i32, i32* %82, align 4, !dbg !349, !tbaa !144
  br label %109, !dbg !350

109:                                              ; preds = %104, %93
  %110 = phi i32 [ %94, %93 ], [ %105, %104 ]
  %111 = phi i32 [ %95, %93 ], [ %108, %104 ], !dbg !349
  %112 = phi i32 [ %96, %93 ], [ %105, %104 ]
  %113 = add nsw i64 %97, 1, !dbg !351
  call void @llvm.dbg.value(metadata i64 %113, metadata !172, metadata !DIExpression()), !dbg !337
  %114 = add nsw i32 %111, 1, !dbg !338
  %115 = sext i32 %114 to i64, !dbg !339
  %116 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %115, !dbg !339
  %117 = load i32, i32* %116, align 4, !dbg !339, !tbaa !144
  %118 = sext i32 %117 to i64, !dbg !340
  %119 = icmp slt i64 %113, %118, !dbg !340
  br i1 %119, label %93, label %120, !dbg !341, !llvm.loop !352

120:                                              ; preds = %109, %78
  %121 = phi i32 [ %80, %78 ], [ %110, %109 ], !dbg !354
  %122 = add nuw nsw i64 %81, 1, !dbg !355
  %123 = sext i32 %121 to i64, !dbg !356
  %124 = icmp slt i64 %122, %123, !dbg !356
  br i1 %124, label %125, label %128, !dbg !334, !llvm.loop !357

125:                                              ; preds = %120
  %126 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @bfs_queue, i64 0, i64 %122, !dbg !337
  %127 = load i32, i32* %126, align 4, !dbg !335, !tbaa !144
  br label %78, !dbg !334

128:                                              ; preds = %120
  call void @llvm.dbg.value(metadata i32 0, metadata !248, metadata !DIExpression()), !dbg !359
  call void @llvm.memset.p0i8.i64(i8* align 1 getelementptr inbounds ([10000000 x i8], [10000000 x i8]* @vis, i64 0, i64 0), i8 0, i64 %77, i1 false), !dbg !360
  call void @llvm.dbg.value(metadata i32 undef, metadata !248, metadata !DIExpression()), !dbg !359
  call void @llvm.dbg.value(metadata i32 undef, metadata !245, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !328
  br label %187, !dbg !355

129:                                              ; preds = %27, %129
  %130 = phi i32 [ %31, %27 ], [ %135, %129 ], !dbg !286
  %131 = phi i64 [ 0, %27 ], [ %132, %129 ]
  call void @llvm.dbg.value(metadata i64 %131, metadata !243, metadata !DIExpression()), !dbg !278
  %132 = add nuw nsw i64 %131, 1, !dbg !362
  %133 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %132, !dbg !363
  %134 = load i32, i32* %133, align 4, !dbg !364, !tbaa !144
  %135 = add nsw i32 %134, %130, !dbg !364
  store i32 %135, i32* %133, align 4, !dbg !364, !tbaa !144
  call void @llvm.dbg.value(metadata i64 %132, metadata !243, metadata !DIExpression()), !dbg !278
  %136 = icmp ult i64 %132, %28, !dbg !281
  br i1 %136, label %129, label %53, !dbg !282, !llvm.loop !365

137:                                              ; preds = %74, %157
  %138 = phi i32 [ %159, %157 ], [ %59, %74 ], !dbg !335
  %139 = phi i32 [ %153, %157 ], [ 1, %74 ]
  %140 = phi i64 [ %154, %157 ], [ 0, %74 ]
  %141 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @bfs_queue, i64 0, i64 %140, !dbg !335
  %142 = sext i32 %138 to i64, !dbg !336
  %143 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %142, !dbg !336
  %144 = load i32, i32* %143, align 4, !dbg !336, !tbaa !144
  call void @llvm.dbg.value(metadata i32 %144, metadata !172, metadata !DIExpression()), !dbg !337
  %145 = add nsw i32 %138, 1, !dbg !338
  %146 = sext i32 %145 to i64, !dbg !339
  %147 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %146, !dbg !339
  %148 = load i32, i32* %147, align 4, !dbg !339, !tbaa !144
  %149 = icmp slt i32 %144, %148, !dbg !340
  br i1 %149, label %150, label %152, !dbg !341

150:                                              ; preds = %137
  %151 = sext i32 %144 to i64, !dbg !341
  br label %160, !dbg !341

152:                                              ; preds = %176, %137
  %153 = phi i32 [ %139, %137 ], [ %177, %176 ], !dbg !354
  %154 = add nuw nsw i64 %140, 1, !dbg !355
  %155 = sext i32 %153 to i64, !dbg !356
  %156 = icmp slt i64 %154, %155, !dbg !356
  br i1 %156, label %157, label %187, !dbg !334, !llvm.loop !357

157:                                              ; preds = %152
  %158 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @bfs_queue, i64 0, i64 %154, !dbg !337
  %159 = load i32, i32* %158, align 4, !dbg !335, !tbaa !144
  br label %137, !dbg !334

160:                                              ; preds = %176, %150
  %161 = phi i32 [ %139, %150 ], [ %177, %176 ]
  %162 = phi i32 [ %138, %150 ], [ %178, %176 ]
  %163 = phi i32 [ %139, %150 ], [ %179, %176 ]
  %164 = phi i64 [ %151, %150 ], [ %180, %176 ]
  call void @llvm.dbg.value(metadata i64 %164, metadata !172, metadata !DIExpression()), !dbg !337
  %165 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @col_idx, i64 0, i64 %164, !dbg !342
  %166 = load i32, i32* %165, align 4, !dbg !342, !tbaa !144
  %167 = sext i32 %166 to i64, !dbg !343
  %168 = getelementptr inbounds [10000000 x i8], [10000000 x i8]* @vis, i64 0, i64 %167, !dbg !343
  %169 = load i8, i8* %168, align 1, !dbg !343, !tbaa !162, !range !195
  %170 = icmp eq i8 %169, 0, !dbg !343
  br i1 %170, label %171, label %176, !dbg !344

171:                                              ; preds = %160
  %172 = add nsw i32 %163, 1, !dbg !345
  %173 = sext i32 %163 to i64, !dbg !346
  %174 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @bfs_queue, i64 0, i64 %173, !dbg !346
  store i32 %166, i32* %174, align 4, !dbg !347, !tbaa !144
  store i8 1, i8* %168, align 1, !dbg !348, !tbaa !162
  %175 = load i32, i32* %141, align 4, !dbg !349, !tbaa !144
  br label %176, !dbg !350

176:                                              ; preds = %171, %160
  %177 = phi i32 [ %161, %160 ], [ %172, %171 ]
  %178 = phi i32 [ %162, %160 ], [ %175, %171 ], !dbg !349
  %179 = phi i32 [ %163, %160 ], [ %172, %171 ]
  %180 = add nsw i64 %164, 1, !dbg !351
  call void @llvm.dbg.value(metadata i64 %180, metadata !172, metadata !DIExpression()), !dbg !337
  %181 = add nsw i32 %178, 1, !dbg !338
  %182 = sext i32 %181 to i64, !dbg !339
  %183 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %182, !dbg !339
  %184 = load i32, i32* %183, align 4, !dbg !339, !tbaa !144
  %185 = sext i32 %184 to i64, !dbg !340
  %186 = icmp slt i64 %180, %185, !dbg !340
  br i1 %186, label %160, label %152, !dbg !341, !llvm.loop !352

187:                                              ; preds = %152, %128
  store i8 1, i8* %69, align 1, !dbg !367, !tbaa !162
  store i32 0, i32* @queue_start_ptr, align 4, !dbg !355, !tbaa !144
  store i32 1, i32* @queue_end_ptr, align 4, !dbg !345, !tbaa !144
  br label %188, !dbg !368

188:                                              ; preds = %187, %67
  call void @m5_reset_stats(i64 0, i64 0) #13, !dbg !368
  call void @llvm.dbg.value(metadata i32 undef, metadata !171, metadata !DIExpression()), !dbg !369
  %189 = load i32, i32* @queue_start_ptr, align 4, !dbg !371, !tbaa !144
  %190 = load i32, i32* @queue_end_ptr, align 4, !dbg !372, !tbaa !144
  %191 = icmp slt i32 %189, %190, !dbg !373
  br i1 %191, label %192, label %243, !dbg !374

192:                                              ; preds = %188
  %193 = sext i32 %189 to i64, !dbg !374
  br label %194, !dbg !374

194:                                              ; preds = %209, %192
  %195 = phi i32 [ %190, %192 ], [ %210, %209 ]
  %196 = phi i64 [ %193, %192 ], [ %211, %209 ]
  %197 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @bfs_queue, i64 0, i64 %196, !dbg !375
  %198 = load i32, i32* %197, align 4, !dbg !375, !tbaa !144
  %199 = sext i32 %198 to i64, !dbg !376
  %200 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %199, !dbg !376
  %201 = load i32, i32* %200, align 4, !dbg !376, !tbaa !144
  call void @llvm.dbg.value(metadata i32 %201, metadata !172, metadata !DIExpression()), !dbg !377
  %202 = add nsw i32 %198, 1, !dbg !378
  %203 = sext i32 %202 to i64, !dbg !379
  %204 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %203, !dbg !379
  %205 = load i32, i32* %204, align 4, !dbg !379, !tbaa !144
  %206 = icmp slt i32 %201, %205, !dbg !380
  br i1 %206, label %207, label %209, !dbg !381

207:                                              ; preds = %194
  %208 = sext i32 %201 to i64, !dbg !381
  br label %214, !dbg !381

209:                                              ; preds = %230, %194
  %210 = phi i32 [ %195, %194 ], [ %231, %230 ], !dbg !372
  %211 = add nsw i64 %196, 1, !dbg !382
  %212 = sext i32 %210 to i64, !dbg !373
  %213 = icmp slt i64 %211, %212, !dbg !373
  br i1 %213, label %194, label %241, !dbg !374, !llvm.loop !383

214:                                              ; preds = %230, %207
  %215 = phi i32 [ %195, %207 ], [ %231, %230 ]
  %216 = phi i32 [ %198, %207 ], [ %232, %230 ]
  %217 = phi i32 [ %195, %207 ], [ %233, %230 ]
  %218 = phi i64 [ %208, %207 ], [ %234, %230 ]
  call void @llvm.dbg.value(metadata i64 %218, metadata !172, metadata !DIExpression()), !dbg !377
  %219 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @col_idx, i64 0, i64 %218, !dbg !385
  %220 = load i32, i32* %219, align 4, !dbg !385, !tbaa !144
  %221 = sext i32 %220 to i64, !dbg !386
  %222 = getelementptr inbounds [10000000 x i8], [10000000 x i8]* @vis, i64 0, i64 %221, !dbg !386
  %223 = load i8, i8* %222, align 1, !dbg !386, !tbaa !162, !range !195
  %224 = icmp eq i8 %223, 0, !dbg !386
  br i1 %224, label %225, label %230, !dbg !387

225:                                              ; preds = %214
  %226 = add nsw i32 %217, 1, !dbg !388
  store i32 %226, i32* @queue_end_ptr, align 4, !dbg !388, !tbaa !144
  %227 = sext i32 %217 to i64, !dbg !389
  %228 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @bfs_queue, i64 0, i64 %227, !dbg !389
  store i32 %220, i32* %228, align 4, !dbg !390, !tbaa !144
  store i8 1, i8* %222, align 1, !dbg !391, !tbaa !162
  %229 = load i32, i32* %197, align 4, !dbg !392, !tbaa !144
  br label %230, !dbg !393

230:                                              ; preds = %225, %214
  %231 = phi i32 [ %215, %214 ], [ %226, %225 ]
  %232 = phi i32 [ %216, %214 ], [ %229, %225 ], !dbg !392
  %233 = phi i32 [ %217, %214 ], [ %226, %225 ]
  %234 = add nsw i64 %218, 1, !dbg !394
  call void @llvm.dbg.value(metadata i64 %234, metadata !172, metadata !DIExpression()), !dbg !377
  %235 = add nsw i32 %232, 1, !dbg !378
  %236 = sext i32 %235 to i64, !dbg !379
  %237 = getelementptr inbounds [10000000 x i32], [10000000 x i32]* @row_ptr, i64 0, i64 %236, !dbg !379
  %238 = load i32, i32* %237, align 4, !dbg !379, !tbaa !144
  %239 = sext i32 %238 to i64, !dbg !380
  %240 = icmp slt i64 %234, %239, !dbg !380
  br i1 %240, label %214, label %209, !dbg !381, !llvm.loop !395

241:                                              ; preds = %209
  %242 = trunc i64 %211 to i32, !dbg !382
  store i32 %242, i32* @queue_start_ptr, align 4, !dbg !382, !tbaa !144
  br label %243, !dbg !374

243:                                              ; preds = %188, %241
  call void @m5_exit(i64 0) #13, !dbg !397
  %244 = call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([14 x i8], [14 x i8]* @str.14, i64 0, i64 0)), !dbg !398
  ret i32 0, !dbg !399
}

; Function Attrs: nofree nounwind
declare dso_local noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #1

declare dso_local i32 @__isoc99_fscanf(%struct._IO_FILE*, i8*, ...) local_unnamed_addr #8

; Function Attrs: nofree nounwind
declare !dbg !12 dso_local i32 @fclose(%struct._IO_FILE* nocapture) local_unnamed_addr #1

declare !dbg !74 dso_local void @m5_checkpoint(i64, i64) local_unnamed_addr #8

; Function Attrs: nofree nounwind readonly
declare dso_local i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #9

declare !dbg !78 dso_local void @m5_reset_stats(i64, i64) local_unnamed_addr #8

declare !dbg !79 dso_local void @m5_exit(i64) local_unnamed_addr #8

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #10

; Function Attrs: nofree nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #11

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

attributes #0 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind willreturn }
attributes #5 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nofree norecurse nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { nofree nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { nounwind readnone speculatable willreturn }
attributes #11 = { nofree nounwind }
attributes #12 = { noreturn nounwind }
attributes #13 = { nounwind }
attributes #14 = { nounwind readonly }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!127, !128, !129}
!llvm.ident = !{!130}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "depth", scope: !2, file: !3, line: 19, type: !10, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 10.0.1-++20211003084855+ef32c611aa21-1~exp1~20211003085243.2", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !82, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "src/bfs_m5.c", directory: "/home/fugelin/Work/Research/gem5/prefetch_project/sam_swpf/program/bfs")
!4 = !{}
!5 = !{!6, !11, !12, !74, !78, !79}
!6 = !DISubprogram(name: "rand", scope: !7, file: !7, line: 453, type: !8, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !4)
!7 = !DIFile(filename: "/usr/aarch64-linux-gnu/include/stdlib.h", directory: "")
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!12 = !DISubprogram(name: "fclose", scope: !13, file: !13, line: 199, type: !14, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !4)
!13 = !DIFile(filename: "/usr/aarch64-linux-gnu/include/stdio.h", directory: "")
!14 = !DISubroutineType(types: !15)
!15 = !{!10, !16}
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !18, line: 245, size: 1728, elements: !19)
!18 = !DIFile(filename: "/usr/aarch64-linux-gnu/include/bits/libio.h", directory: "")
!19 = !{!20, !21, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !41, !42, !43, !44, !48, !50, !52, !56, !59, !61, !62, !63, !64, !65, !69, !70}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !17, file: !18, line: 246, baseType: !10, size: 32)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !17, file: !18, line: 251, baseType: !22, size: 64, offset: 64)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_unsigned_char)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !17, file: !18, line: 252, baseType: !22, size: 64, offset: 128)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !17, file: !18, line: 253, baseType: !22, size: 64, offset: 192)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !17, file: !18, line: 254, baseType: !22, size: 64, offset: 256)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !17, file: !18, line: 255, baseType: !22, size: 64, offset: 320)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !17, file: !18, line: 256, baseType: !22, size: 64, offset: 384)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !17, file: !18, line: 257, baseType: !22, size: 64, offset: 448)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !17, file: !18, line: 258, baseType: !22, size: 64, offset: 512)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !17, file: !18, line: 260, baseType: !22, size: 64, offset: 576)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !17, file: !18, line: 261, baseType: !22, size: 64, offset: 640)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !17, file: !18, line: 262, baseType: !22, size: 64, offset: 704)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !17, file: !18, line: 264, baseType: !35, size: 64, offset: 768)
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !36, size: 64)
!36 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !18, line: 160, size: 192, elements: !37)
!37 = !{!38, !39, !40}
!38 = !DIDerivedType(tag: DW_TAG_member, name: "_next", scope: !36, file: !18, line: 161, baseType: !35, size: 64)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "_sbuf", scope: !36, file: !18, line: 162, baseType: !16, size: 64, offset: 64)
!40 = !DIDerivedType(tag: DW_TAG_member, name: "_pos", scope: !36, file: !18, line: 166, baseType: !10, size: 32, offset: 128)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !17, file: !18, line: 266, baseType: !16, size: 64, offset: 832)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !17, file: !18, line: 268, baseType: !10, size: 32, offset: 896)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !17, file: !18, line: 272, baseType: !10, size: 32, offset: 928)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !17, file: !18, line: 274, baseType: !45, size: 64, offset: 960)
!45 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !46, line: 140, baseType: !47)
!46 = !DIFile(filename: "/usr/aarch64-linux-gnu/include/bits/types.h", directory: "")
!47 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !17, file: !18, line: 278, baseType: !49, size: 16, offset: 1024)
!49 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !17, file: !18, line: 279, baseType: !51, size: 8, offset: 1040)
!51 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !17, file: !18, line: 280, baseType: !53, size: 8, offset: 1048)
!53 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 8, elements: !54)
!54 = !{!55}
!55 = !DISubrange(count: 1)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !17, file: !18, line: 284, baseType: !57, size: 64, offset: 1088)
!57 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !58, size: 64)
!58 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !18, line: 154, baseType: null)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !17, file: !18, line: 293, baseType: !60, size: 64, offset: 1152)
!60 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !46, line: 141, baseType: !47)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !17, file: !18, line: 301, baseType: !11, size: 64, offset: 1216)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !17, file: !18, line: 302, baseType: !11, size: 64, offset: 1280)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "__pad3", scope: !17, file: !18, line: 303, baseType: !11, size: 64, offset: 1344)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "__pad4", scope: !17, file: !18, line: 304, baseType: !11, size: 64, offset: 1408)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "__pad5", scope: !17, file: !18, line: 306, baseType: !66, size: 64, offset: 1472)
!66 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !67, line: 46, baseType: !68)
!67 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.1/include/stddef.h", directory: "")
!68 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !17, file: !18, line: 307, baseType: !10, size: 32, offset: 1536)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !17, file: !18, line: 309, baseType: !71, size: 160, offset: 1568)
!71 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 160, elements: !72)
!72 = !{!73}
!73 = !DISubrange(count: 20)
!74 = !DISubprogram(name: "m5_checkpoint", scope: !75, file: !75, line: 54, type: !76, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !4)
!75 = !DIFile(filename: "src/../../../../gem5_bfs/include/gem5/m5ops.h", directory: "/home/fugelin/Work/Research/gem5/prefetch_project/sam_swpf/program/bfs")
!76 = !DISubroutineType(types: !77)
!77 = !{null, !68, !68}
!78 = !DISubprogram(name: "m5_reset_stats", scope: !75, file: !75, line: 55, type: !76, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !4)
!79 = !DISubprogram(name: "m5_exit", scope: !75, file: !75, line: 48, type: !80, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !4)
!80 = !DISubroutineType(types: !81)
!81 = !{null, !68}
!82 = !{!0, !83, !85, !87, !89, !91, !93, !95, !97, !100, !102, !107, !109, !111, !113, !117, !119, !122}
!83 = !DIGlobalVariableExpression(var: !84, expr: !DIExpression())
!84 = distinct !DIGlobalVariable(name: "queue_start_ptr", scope: !2, file: !3, line: 40, type: !10, isLocal: false, isDefinition: true)
!85 = !DIGlobalVariableExpression(var: !86, expr: !DIExpression())
!86 = distinct !DIGlobalVariable(name: "queue_end_ptr", scope: !2, file: !3, line: 40, type: !10, isLocal: false, isDefinition: true)
!87 = !DIGlobalVariableExpression(var: !88, expr: !DIExpression())
!88 = distinct !DIGlobalVariable(name: "row", scope: !2, file: !3, line: 19, type: !10, isLocal: false, isDefinition: true)
!89 = !DIGlobalVariableExpression(var: !90, expr: !DIExpression())
!90 = distinct !DIGlobalVariable(name: "col", scope: !2, file: !3, line: 19, type: !10, isLocal: false, isDefinition: true)
!91 = !DIGlobalVariableExpression(var: !92, expr: !DIExpression())
!92 = distinct !DIGlobalVariable(name: "nnz", scope: !2, file: !3, line: 19, type: !10, isLocal: false, isDefinition: true)
!93 = !DIGlobalVariableExpression(var: !94, expr: !DIExpression())
!94 = distinct !DIGlobalVariable(name: "temp_row", scope: !2, file: !3, line: 20, type: !10, isLocal: false, isDefinition: true)
!95 = !DIGlobalVariableExpression(var: !96, expr: !DIExpression())
!96 = distinct !DIGlobalVariable(name: "temp_column", scope: !2, file: !3, line: 20, type: !10, isLocal: false, isDefinition: true)
!97 = !DIGlobalVariableExpression(var: !98, expr: !DIExpression())
!98 = distinct !DIGlobalVariable(name: "temp_value", scope: !2, file: !3, line: 21, type: !99, isLocal: false, isDefinition: true)
!99 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!100 = !DIGlobalVariableExpression(var: !101, expr: !DIExpression())
!101 = distinct !DIGlobalVariable(name: "start_point", scope: !2, file: !3, line: 22, type: !10, isLocal: false, isDefinition: true)
!102 = !DIGlobalVariableExpression(var: !103, expr: !DIExpression())
!103 = distinct !DIGlobalVariable(name: "out_degree", scope: !2, file: !3, line: 32, type: !104, isLocal: false, isDefinition: true)
!104 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 320000000, elements: !105)
!105 = !{!106}
!106 = !DISubrange(count: 10000000)
!107 = !DIGlobalVariableExpression(var: !108, expr: !DIExpression())
!108 = distinct !DIGlobalVariable(name: "result", scope: !2, file: !3, line: 33, type: !104, isLocal: false, isDefinition: true)
!109 = !DIGlobalVariableExpression(var: !110, expr: !DIExpression())
!110 = distinct !DIGlobalVariable(name: "col_idx", scope: !2, file: !3, line: 34, type: !104, isLocal: false, isDefinition: true)
!111 = !DIGlobalVariableExpression(var: !112, expr: !DIExpression())
!112 = distinct !DIGlobalVariable(name: "row_ptr", scope: !2, file: !3, line: 35, type: !104, isLocal: false, isDefinition: true)
!113 = !DIGlobalVariableExpression(var: !114, expr: !DIExpression())
!114 = distinct !DIGlobalVariable(name: "vis", scope: !2, file: !3, line: 36, type: !115, isLocal: false, isDefinition: true)
!115 = !DICompositeType(tag: DW_TAG_array_type, baseType: !116, size: 80000000, elements: !105)
!116 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!117 = !DIGlobalVariableExpression(var: !118, expr: !DIExpression())
!118 = distinct !DIGlobalVariable(name: "bfs_queue", scope: !2, file: !3, line: 37, type: !104, isLocal: false, isDefinition: true)
!119 = !DIGlobalVariableExpression(var: !120, expr: !DIExpression())
!120 = distinct !DIGlobalVariable(name: "value", scope: !2, file: !3, line: 38, type: !121, isLocal: false, isDefinition: true)
!121 = !DICompositeType(tag: DW_TAG_array_type, baseType: !99, size: 640000000, elements: !105)
!122 = !DIGlobalVariableExpression(var: !123, expr: !DIExpression())
!123 = distinct !DIGlobalVariable(name: "cache_flush", scope: !2, file: !3, line: 45, type: !124, isLocal: false, isDefinition: true)
!124 = !DICompositeType(tag: DW_TAG_array_type, baseType: !99, size: 67108864, elements: !125)
!125 = !{!126}
!126 = !DISubrange(count: 1048576)
!127 = !{i32 7, !"Dwarf Version", i32 4}
!128 = !{i32 2, !"Debug Info Version", i32 3}
!129 = !{i32 1, !"wchar_size", i32 4}
!130 = !{!"Ubuntu clang version 10.0.1-++20211003084855+ef32c611aa21-1~exp1~20211003085243.2"}
!131 = distinct !DISubprogram(name: "handle_error", scope: !3, file: !3, line: 47, type: !132, scopeLine: 48, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !4)
!132 = !DISubroutineType(types: !133)
!133 = !{null}
!134 = !DILocation(line: 49, column: 5, scope: !131)
!135 = !DILocation(line: 50, column: 5, scope: !131)
!136 = distinct !DISubprogram(name: "generate_start_point", scope: !3, file: !3, line: 53, type: !132, scopeLine: 54, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !137)
!137 = !{!138}
!138 = !DILocalVariable(name: "cnt", scope: !136, file: !3, line: 56, type: !10)
!139 = !DILocation(line: 0, scope: !136)
!140 = !DILocation(line: 57, column: 5, scope: !136)
!141 = !DILocation(line: 59, column: 23, scope: !142)
!142 = distinct !DILexicalBlock(scope: !136, file: !3, line: 58, column: 5)
!143 = !DILocation(line: 59, column: 32, scope: !142)
!144 = !{!145, !145, i64 0}
!145 = !{!"int", !146, i64 0}
!146 = !{!"omnipotent char", !147, i64 0}
!147 = !{!"Simple C/C++ TBAA"}
!148 = !DILocation(line: 59, column: 30, scope: !142)
!149 = !DILocation(line: 59, column: 21, scope: !142)
!150 = !DILocation(line: 60, column: 12, scope: !142)
!151 = !DILocation(line: 61, column: 14, scope: !136)
!152 = !DILocation(line: 61, column: 38, scope: !136)
!153 = !DILocation(line: 61, column: 43, scope: !136)
!154 = !DILocation(line: 61, column: 5, scope: !142)
!155 = distinct !{!155, !140, !156}
!156 = !DILocation(line: 61, column: 56, scope: !136)
!157 = !DILocation(line: 62, column: 18, scope: !136)
!158 = !DILocation(line: 63, column: 5, scope: !136)
!159 = !DILocation(line: 63, column: 25, scope: !136)
!160 = !DILocation(line: 64, column: 5, scope: !136)
!161 = !DILocation(line: 64, column: 22, scope: !136)
!162 = !{!163, !163, i64 0}
!163 = !{!"_Bool", !146, i64 0}
!164 = !DILocation(line: 65, column: 21, scope: !136)
!165 = !DILocation(line: 66, column: 19, scope: !136)
!166 = !DILocation(line: 67, column: 1, scope: !136)
!167 = distinct !DISubprogram(name: "BFS_kernel", scope: !3, file: !3, line: 69, type: !168, scopeLine: 70, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !170)
!168 = !DISubroutineType(types: !169)
!169 = !{null, !10}
!170 = !{!171, !172}
!171 = !DILocalVariable(name: "depth", arg: 1, scope: !167, file: !3, line: 69, type: !10)
!172 = !DILocalVariable(name: "i", scope: !173, file: !3, line: 73, type: !10)
!173 = distinct !DILexicalBlock(scope: !174, file: !3, line: 73, column: 9)
!174 = distinct !DILexicalBlock(scope: !167, file: !3, line: 71, column: 41)
!175 = !DILocation(line: 0, scope: !167)
!176 = !DILocation(line: 71, column: 11, scope: !167)
!177 = !DILocation(line: 71, column: 27, scope: !167)
!178 = !DILocation(line: 71, column: 26, scope: !167)
!179 = !DILocation(line: 71, column: 5, scope: !167)
!180 = !DILocation(line: 73, column: 30, scope: !173)
!181 = !DILocation(line: 73, column: 22, scope: !173)
!182 = !DILocation(line: 0, scope: !173)
!183 = !DILocation(line: 73, column: 98, scope: !184)
!184 = distinct !DILexicalBlock(scope: !173, file: !3, line: 73, column: 9)
!185 = !DILocation(line: 73, column: 63, scope: !184)
!186 = !DILocation(line: 73, column: 61, scope: !184)
!187 = !DILocation(line: 73, column: 9, scope: !173)
!188 = !DILocation(line: 82, column: 24, scope: !174)
!189 = distinct !{!189, !179, !190}
!190 = !DILocation(line: 83, column: 5, scope: !167)
!191 = !DILocation(line: 75, column: 22, scope: !192)
!192 = distinct !DILexicalBlock(scope: !193, file: !3, line: 75, column: 17)
!193 = distinct !DILexicalBlock(scope: !184, file: !3, line: 74, column: 9)
!194 = !DILocation(line: 75, column: 18, scope: !192)
!195 = !{i8 0, i8 2}
!196 = !DILocation(line: 75, column: 17, scope: !193)
!197 = !DILocation(line: 77, column: 40, scope: !198)
!198 = distinct !DILexicalBlock(scope: !192, file: !3, line: 76, column: 13)
!199 = !DILocation(line: 77, column: 17, scope: !198)
!200 = !DILocation(line: 77, column: 44, scope: !198)
!201 = !DILocation(line: 79, column: 33, scope: !198)
!202 = !DILocation(line: 73, column: 71, scope: !184)
!203 = !DILocation(line: 80, column: 13, scope: !198)
!204 = !DILocation(line: 73, column: 105, scope: !184)
!205 = distinct !{!205, !187, !206}
!206 = !DILocation(line: 81, column: 9, scope: !173)
!207 = !DILocation(line: 84, column: 1, scope: !167)
!208 = distinct !DISubprogram(name: "print_BFS", scope: !3, file: !3, line: 86, type: !132, scopeLine: 87, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !209)
!209 = !{!210}
!210 = !DILocalVariable(name: "i", scope: !211, file: !3, line: 89, type: !10)
!211 = distinct !DILexicalBlock(scope: !208, file: !3, line: 89, column: 5)
!212 = !DILocation(line: 88, column: 38, scope: !208)
!213 = !DILocation(line: 88, column: 50, scope: !208)
!214 = !DILocation(line: 88, column: 5, scope: !208)
!215 = !DILocation(line: 0, scope: !211)
!216 = !DILocation(line: 89, column: 25, scope: !217)
!217 = distinct !DILexicalBlock(scope: !211, file: !3, line: 89, column: 5)
!218 = !DILocation(line: 89, column: 23, scope: !217)
!219 = !DILocation(line: 89, column: 5, scope: !211)
!220 = !DILocation(line: 93, column: 1, scope: !208)
!221 = !DILocation(line: 91, column: 44, scope: !222)
!222 = distinct !DILexicalBlock(scope: !217, file: !3, line: 90, column: 5)
!223 = !DILocation(line: 91, column: 49, scope: !222)
!224 = !DILocation(line: 91, column: 9, scope: !222)
!225 = distinct !{!225, !219, !226}
!226 = !DILocation(line: 92, column: 5, scope: !211)
!227 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 95, type: !228, scopeLine: 96, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !231)
!228 = !DISubroutineType(types: !229)
!229 = !{!10, !10, !230}
!230 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!231 = !{!232, !233, !234, !238, !240, !243, !245, !248}
!232 = !DILocalVariable(name: "argc", arg: 1, scope: !227, file: !3, line: 95, type: !10)
!233 = !DILocalVariable(name: "argv", arg: 2, scope: !227, file: !3, line: 95, type: !230)
!234 = !DILocalVariable(name: "fp", scope: !227, file: !3, line: 99, type: !235)
!235 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !236, size: 64)
!236 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !237, line: 7, baseType: !17)
!237 = !DIFile(filename: "/usr/aarch64-linux-gnu/include/bits/types/FILE.h", directory: "")
!238 = !DILocalVariable(name: "i", scope: !239, file: !3, line: 114, type: !10)
!239 = distinct !DILexicalBlock(scope: !227, file: !3, line: 114, column: 5)
!240 = !DILocalVariable(name: "row_num", scope: !241, file: !3, line: 116, type: !10)
!241 = distinct !DILexicalBlock(scope: !242, file: !3, line: 115, column: 5)
!242 = distinct !DILexicalBlock(scope: !239, file: !3, line: 114, column: 5)
!243 = !DILocalVariable(name: "i", scope: !244, file: !3, line: 122, type: !10)
!244 = distinct !DILexicalBlock(scope: !227, file: !3, line: 122, column: 5)
!245 = !DILocalVariable(name: "i", scope: !246, file: !3, line: 139, type: !10)
!246 = distinct !DILexicalBlock(scope: !247, file: !3, line: 139, column: 9)
!247 = distinct !DILexicalBlock(scope: !227, file: !3, line: 138, column: 9)
!248 = !DILocalVariable(name: "i", scope: !249, file: !3, line: 142, type: !10)
!249 = distinct !DILexicalBlock(scope: !250, file: !3, line: 142, column: 13)
!250 = distinct !DILexicalBlock(scope: !251, file: !3, line: 140, column: 9)
!251 = distinct !DILexicalBlock(scope: !246, file: !3, line: 139, column: 9)
!252 = !DILocation(line: 0, scope: !227)
!253 = !DILocation(line: 97, column: 5, scope: !227)
!254 = !DILocation(line: 99, column: 22, scope: !227)
!255 = !{!256, !256, i64 0}
!256 = !{!"any pointer", !146, i64 0}
!257 = !DILocation(line: 99, column: 16, scope: !227)
!258 = !DILocation(line: 101, column: 12, scope: !259)
!259 = distinct !DILexicalBlock(scope: !227, file: !3, line: 101, column: 9)
!260 = !DILocation(line: 101, column: 9, scope: !227)
!261 = !DILocation(line: 103, column: 9, scope: !262)
!262 = distinct !DILexicalBlock(scope: !259, file: !3, line: 102, column: 5)
!263 = !DILocation(line: 104, column: 9, scope: !262)
!264 = !DILocation(line: 108, column: 9, scope: !265)
!265 = distinct !DILexicalBlock(scope: !259, file: !3, line: 107, column: 5)
!266 = !DILocation(line: 109, column: 24, scope: !265)
!267 = !DILocation(line: 109, column: 9, scope: !265)
!268 = !DILocation(line: 112, column: 5, scope: !227)
!269 = !DILocation(line: 113, column: 84, scope: !227)
!270 = !DILocation(line: 113, column: 89, scope: !227)
!271 = !DILocation(line: 113, column: 94, scope: !227)
!272 = !DILocation(line: 113, column: 5, scope: !227)
!273 = !DILocation(line: 0, scope: !239)
!274 = !DILocation(line: 114, column: 25, scope: !242)
!275 = !DILocation(line: 114, column: 23, scope: !242)
!276 = !DILocation(line: 114, column: 5, scope: !239)
!277 = !DILocation(line: 0, scope: !241)
!278 = !DILocation(line: 0, scope: !244)
!279 = !DILocation(line: 122, column: 25, scope: !280)
!280 = distinct !DILexicalBlock(scope: !244, file: !3, line: 122, column: 5)
!281 = !DILocation(line: 122, column: 23, scope: !280)
!282 = !DILocation(line: 122, column: 5, scope: !244)
!283 = !DILocation(line: 125, column: 19, scope: !284)
!284 = distinct !DILexicalBlock(scope: !280, file: !3, line: 123, column: 5)
!285 = !DILocation(line: 126, column: 16, scope: !284)
!286 = !DILocation(line: 124, column: 27, scope: !284)
!287 = !DILocation(line: 116, column: 9, scope: !241)
!288 = !DILocation(line: 117, column: 42, scope: !241)
!289 = !DILocation(line: 117, column: 55, scope: !241)
!290 = !DILocation(line: 117, column: 9, scope: !241)
!291 = !DILocation(line: 118, column: 19, scope: !241)
!292 = !DILocation(line: 119, column: 24, scope: !241)
!293 = !DILocation(line: 119, column: 9, scope: !241)
!294 = !DILocation(line: 119, column: 27, scope: !241)
!295 = !DILocation(line: 120, column: 9, scope: !241)
!296 = !DILocation(line: 120, column: 28, scope: !241)
!297 = !DILocation(line: 121, column: 5, scope: !242)
!298 = !DILocation(line: 114, column: 31, scope: !242)
!299 = distinct !{!299, !276, !300}
!300 = !DILocation(line: 121, column: 5, scope: !239)
!301 = !DILocation(line: 128, column: 5, scope: !227)
!302 = !DILocation(line: 134, column: 5, scope: !227)
!303 = !DILocation(line: 0, scope: !136, inlinedAt: !304)
!304 = distinct !DILocation(line: 136, column: 5, scope: !227)
!305 = !DILocation(line: 57, column: 5, scope: !136, inlinedAt: !304)
!306 = !DILocation(line: 59, column: 23, scope: !142, inlinedAt: !304)
!307 = !DILocation(line: 59, column: 32, scope: !142, inlinedAt: !304)
!308 = !DILocation(line: 59, column: 30, scope: !142, inlinedAt: !304)
!309 = !DILocation(line: 59, column: 21, scope: !142, inlinedAt: !304)
!310 = !DILocation(line: 60, column: 12, scope: !142, inlinedAt: !304)
!311 = !DILocation(line: 61, column: 14, scope: !136, inlinedAt: !304)
!312 = !DILocation(line: 61, column: 38, scope: !136, inlinedAt: !304)
!313 = !DILocation(line: 61, column: 43, scope: !136, inlinedAt: !304)
!314 = !DILocation(line: 61, column: 5, scope: !142, inlinedAt: !304)
!315 = distinct !{!315, !305, !316}
!316 = !DILocation(line: 61, column: 56, scope: !136, inlinedAt: !304)
!317 = !DILocation(line: 62, column: 18, scope: !136, inlinedAt: !304)
!318 = !DILocation(line: 63, column: 5, scope: !136, inlinedAt: !304)
!319 = !DILocation(line: 63, column: 25, scope: !136, inlinedAt: !304)
!320 = !DILocation(line: 64, column: 5, scope: !136, inlinedAt: !304)
!321 = !DILocation(line: 64, column: 22, scope: !136, inlinedAt: !304)
!322 = !DILocation(line: 65, column: 21, scope: !136, inlinedAt: !304)
!323 = !DILocation(line: 66, column: 19, scope: !136, inlinedAt: !304)
!324 = !DILocation(line: 138, column: 16, scope: !247)
!325 = !DILocation(line: 138, column: 9, scope: !247)
!326 = !DILocation(line: 138, column: 33, scope: !247)
!327 = !DILocation(line: 138, column: 9, scope: !227)
!328 = !DILocation(line: 0, scope: !246)
!329 = !DILocation(line: 0, scope: !330)
!330 = distinct !DILexicalBlock(scope: !249, file: !3, line: 142, column: 13)
!331 = !DILocation(line: 139, column: 9, scope: !246)
!332 = !DILocation(line: 0, scope: !167, inlinedAt: !333)
!333 = distinct !DILocation(line: 141, column: 13, scope: !250)
!334 = !DILocation(line: 71, column: 5, scope: !167, inlinedAt: !333)
!335 = !DILocation(line: 73, column: 30, scope: !173, inlinedAt: !333)
!336 = !DILocation(line: 73, column: 22, scope: !173, inlinedAt: !333)
!337 = !DILocation(line: 0, scope: !173, inlinedAt: !333)
!338 = !DILocation(line: 73, column: 98, scope: !184, inlinedAt: !333)
!339 = !DILocation(line: 73, column: 63, scope: !184, inlinedAt: !333)
!340 = !DILocation(line: 73, column: 61, scope: !184, inlinedAt: !333)
!341 = !DILocation(line: 73, column: 9, scope: !173, inlinedAt: !333)
!342 = !DILocation(line: 75, column: 22, scope: !192, inlinedAt: !333)
!343 = !DILocation(line: 75, column: 18, scope: !192, inlinedAt: !333)
!344 = !DILocation(line: 75, column: 17, scope: !193, inlinedAt: !333)
!345 = !DILocation(line: 77, column: 40, scope: !198, inlinedAt: !333)
!346 = !DILocation(line: 77, column: 17, scope: !198, inlinedAt: !333)
!347 = !DILocation(line: 77, column: 44, scope: !198, inlinedAt: !333)
!348 = !DILocation(line: 79, column: 33, scope: !198, inlinedAt: !333)
!349 = !DILocation(line: 73, column: 71, scope: !184, inlinedAt: !333)
!350 = !DILocation(line: 80, column: 13, scope: !198, inlinedAt: !333)
!351 = !DILocation(line: 73, column: 105, scope: !184, inlinedAt: !333)
!352 = distinct !{!352, !341, !353}
!353 = !DILocation(line: 81, column: 9, scope: !173, inlinedAt: !333)
!354 = !DILocation(line: 71, column: 27, scope: !167, inlinedAt: !333)
!355 = !DILocation(line: 82, column: 24, scope: !174, inlinedAt: !333)
!356 = !DILocation(line: 71, column: 26, scope: !167, inlinedAt: !333)
!357 = distinct !{!357, !334, !358}
!358 = !DILocation(line: 83, column: 5, scope: !167, inlinedAt: !333)
!359 = !DILocation(line: 0, scope: !249)
!360 = !DILocation(line: 144, column: 24, scope: !361)
!361 = distinct !DILexicalBlock(scope: !330, file: !3, line: 143, column: 13)
!362 = !DILocation(line: 124, column: 19, scope: !284)
!363 = !DILocation(line: 124, column: 9, scope: !284)
!364 = !DILocation(line: 124, column: 24, scope: !284)
!365 = distinct !{!365, !282, !366}
!366 = !DILocation(line: 127, column: 5, scope: !244)
!367 = !DILocation(line: 146, column: 30, scope: !250)
!368 = !DILocation(line: 151, column: 5, scope: !227)
!369 = !DILocation(line: 0, scope: !167, inlinedAt: !370)
!370 = distinct !DILocation(line: 152, column: 5, scope: !227)
!371 = !DILocation(line: 71, column: 11, scope: !167, inlinedAt: !370)
!372 = !DILocation(line: 71, column: 27, scope: !167, inlinedAt: !370)
!373 = !DILocation(line: 71, column: 26, scope: !167, inlinedAt: !370)
!374 = !DILocation(line: 71, column: 5, scope: !167, inlinedAt: !370)
!375 = !DILocation(line: 73, column: 30, scope: !173, inlinedAt: !370)
!376 = !DILocation(line: 73, column: 22, scope: !173, inlinedAt: !370)
!377 = !DILocation(line: 0, scope: !173, inlinedAt: !370)
!378 = !DILocation(line: 73, column: 98, scope: !184, inlinedAt: !370)
!379 = !DILocation(line: 73, column: 63, scope: !184, inlinedAt: !370)
!380 = !DILocation(line: 73, column: 61, scope: !184, inlinedAt: !370)
!381 = !DILocation(line: 73, column: 9, scope: !173, inlinedAt: !370)
!382 = !DILocation(line: 82, column: 24, scope: !174, inlinedAt: !370)
!383 = distinct !{!383, !374, !384}
!384 = !DILocation(line: 83, column: 5, scope: !167, inlinedAt: !370)
!385 = !DILocation(line: 75, column: 22, scope: !192, inlinedAt: !370)
!386 = !DILocation(line: 75, column: 18, scope: !192, inlinedAt: !370)
!387 = !DILocation(line: 75, column: 17, scope: !193, inlinedAt: !370)
!388 = !DILocation(line: 77, column: 40, scope: !198, inlinedAt: !370)
!389 = !DILocation(line: 77, column: 17, scope: !198, inlinedAt: !370)
!390 = !DILocation(line: 77, column: 44, scope: !198, inlinedAt: !370)
!391 = !DILocation(line: 79, column: 33, scope: !198, inlinedAt: !370)
!392 = !DILocation(line: 73, column: 71, scope: !184, inlinedAt: !370)
!393 = !DILocation(line: 80, column: 13, scope: !198, inlinedAt: !370)
!394 = !DILocation(line: 73, column: 105, scope: !184, inlinedAt: !370)
!395 = distinct !{!395, !381, !396}
!396 = !DILocation(line: 81, column: 9, scope: !173, inlinedAt: !370)
!397 = !DILocation(line: 153, column: 5, scope: !227)
!398 = !DILocation(line: 159, column: 5, scope: !227)
!399 = !DILocation(line: 162, column: 1, scope: !227)
