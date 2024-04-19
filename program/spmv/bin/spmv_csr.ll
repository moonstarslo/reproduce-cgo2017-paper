; ModuleID = 'src/spmv_csr.cpp'
source_filename = "src/spmv_csr.cpp"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%struct.COO = type { i32, i32, double }
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@cache_flush = dso_local local_unnamed_addr global [65536 x double] zeroinitializer, align 8, !dbg !0
@row = dso_local global i32 0, align 4, !dbg !76
@col = dso_local global i32 0, align 4, !dbg !78
@nnz = dso_local global i32 0, align 4, !dbg !80
@mat = dso_local global [10000000 x %struct.COO] zeroinitializer, align 8, !dbg !82
@.str.1 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"\E6\96\87\E4\BB\B6\E8\B7\AF\E5\BE\84\E4\B8\BA\00", align 1
@.str.5 = private unnamed_addr constant [7 x i8] c"%d%d%d\00", align 1
@.str.6 = private unnamed_addr constant [68 x i8] c"\E7\A8\80\E7\96\8F\E7\9F\A9\E9\98\B5\E4\B8\AD\EF\BC\8C\E8\A1\8C\E6\95\B0\E4\B8\BA%d\EF\BC\8C\E5\88\97\E6\95\B0\E4\B8\BA%d\EF\BC\8C\E9\9D\9E\E9\9B\B6\E5\85\83\E7\B4\A0\E5\85\B1\E6\9C\89%d\0A\00", align 1
@.str.8 = private unnamed_addr constant [8 x i8] c"%d%d%lf\00", align 1
@.str.9 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@str = private unnamed_addr constant [11 x i8] c"start mmap\00", align 1
@str.11 = private unnamed_addr constant [24 x i8] c"the processor is warmed\00", align 1
@str.12 = private unnamed_addr constant [48 x i8] c"nnz/col/row\E4\B8\AD\E6\9C\89\E4\B8\80\E4\B8\AA\E8\AE\BE\E7\BD\AE\E5\A4\A7\E4\BA\8E\E9\A2\84\E8\AE\BE\E5\80\BC\EF\BC\81\00", align 1
@str.13 = private unnamed_addr constant [19 x i8] c"null file pointer!\00", align 1

; Function Attrs: nofree norecurse nounwind
define dso_local void @_Z3mulPdS_S_PiS0_(double* nocapture %0, double* nocapture readonly %1, double* nocapture readonly %2, i32* nocapture readonly %3, i32* nocapture readonly %4) local_unnamed_addr #0 !dbg !107 {
  call void @llvm.dbg.value(metadata double* %0, metadata !111, metadata !DIExpression()), !dbg !124
  call void @llvm.dbg.value(metadata double* %1, metadata !112, metadata !DIExpression()), !dbg !124
  call void @llvm.dbg.value(metadata double* %2, metadata !113, metadata !DIExpression()), !dbg !124
  call void @llvm.dbg.value(metadata i32* %3, metadata !114, metadata !DIExpression()), !dbg !124
  call void @llvm.dbg.value(metadata i32* %4, metadata !115, metadata !DIExpression()), !dbg !124
  call void @llvm.dbg.value(metadata i32 0, metadata !118, metadata !DIExpression()), !dbg !125
  %6 = load i32, i32* @row, align 4, !dbg !126, !tbaa !127
  %7 = icmp sgt i32 %6, 0, !dbg !131
  br i1 %7, label %8, label %13, !dbg !132

8:                                                ; preds = %5
  %9 = zext i32 %6 to i64, !dbg !132
  %10 = load i32, i32* %3, align 4, !dbg !133, !tbaa !127
  br label %14, !dbg !132

11:                                               ; preds = %26, %14
  call void @llvm.dbg.value(metadata i64 %17, metadata !118, metadata !DIExpression()), !dbg !125
  %12 = icmp ult i64 %17, %9, !dbg !131
  br i1 %12, label %14, label %13, !dbg !132

13:                                               ; preds = %11, %5
  ret void, !dbg !134

14:                                               ; preds = %8, %11
  %15 = phi i32 [ %10, %8 ], [ %19, %11 ], !dbg !133
  %16 = phi i64 [ 0, %8 ], [ %17, %11 ]
  call void @llvm.dbg.value(metadata i64 %16, metadata !118, metadata !DIExpression()), !dbg !125
  call void @llvm.dbg.value(metadata i32 %15, metadata !116, metadata !DIExpression()), !dbg !124
  %17 = add nuw nsw i64 %16, 1, !dbg !135
  %18 = getelementptr inbounds i32, i32* %3, i64 %17, !dbg !136
  %19 = load i32, i32* %18, align 4, !dbg !136, !tbaa !127
  call void @llvm.dbg.value(metadata i32 %19, metadata !117, metadata !DIExpression()), !dbg !124
  call void @llvm.dbg.value(metadata i32 %15, metadata !120, metadata !DIExpression()), !dbg !137
  %20 = icmp slt i32 %15, %19, !dbg !138
  br i1 %20, label %21, label %11, !dbg !140, !llvm.loop !141

21:                                               ; preds = %14
  %22 = getelementptr inbounds double, double* %0, i64 %16, !dbg !143
  %23 = sext i32 %15 to i64, !dbg !140
  %24 = sext i32 %19 to i64, !dbg !138
  %25 = load double, double* %22, align 8, !dbg !145, !tbaa !146
  br label %26, !dbg !140

26:                                               ; preds = %26, %21
  %27 = phi double [ %25, %21 ], [ %37, %26 ], !dbg !145
  %28 = phi i64 [ %23, %21 ], [ %38, %26 ]
  call void @llvm.dbg.value(metadata i64 %28, metadata !120, metadata !DIExpression()), !dbg !137
  %29 = getelementptr inbounds double, double* %2, i64 %28, !dbg !148
  %30 = load double, double* %29, align 8, !dbg !148, !tbaa !146
  %31 = getelementptr inbounds i32, i32* %4, i64 %28, !dbg !149
  %32 = load i32, i32* %31, align 4, !dbg !149, !tbaa !127
  %33 = sext i32 %32 to i64, !dbg !150
  %34 = getelementptr inbounds double, double* %1, i64 %33, !dbg !150
  %35 = load double, double* %34, align 8, !dbg !150, !tbaa !146
  %36 = fmul double %30, %35, !dbg !151
  %37 = fadd double %27, %36, !dbg !145
  store double %37, double* %22, align 8, !dbg !145, !tbaa !146
  %38 = add nsw i64 %28, 1, !dbg !152
  call void @llvm.dbg.value(metadata i64 %38, metadata !120, metadata !DIExpression()), !dbg !137
  %39 = icmp eq i64 %38, %24, !dbg !138
  br i1 %39, label %11, label %26, !dbg !140, !llvm.loop !153
}

; Function Attrs: norecurse
define dso_local i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr #1 !dbg !155 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !160, metadata !DIExpression()), !dbg !195
  call void @llvm.dbg.value(metadata i8** %1, metadata !161, metadata !DIExpression()), !dbg !195
  %3 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([11 x i8], [11 x i8]* @str, i64 0, i64 0)), !dbg !196
  call void @llvm.dbg.value(metadata i32* inttoptr (i64 2147483648 to i32*), metadata !167, metadata !DIExpression()), !dbg !195
  call void @llvm.dbg.value(metadata i32* inttoptr (i64 2415919104 to i32*), metadata !169, metadata !DIExpression()), !dbg !195
  call void @llvm.dbg.value(metadata double* inttoptr (i64 2684354560 to double*), metadata !170, metadata !DIExpression()), !dbg !195
  call void @llvm.dbg.value(metadata double* inttoptr (i64 2952790016 to double*), metadata !172, metadata !DIExpression()), !dbg !195
  call void @llvm.dbg.value(metadata double* inttoptr (i64 3221225472 to double*), metadata !173, metadata !DIExpression()), !dbg !195
  %4 = getelementptr inbounds i8*, i8** %1, i64 2, !dbg !197
  %5 = load i8*, i8** %4, align 8, !dbg !197, !tbaa !198
  %6 = tail call %struct._IO_FILE* @fopen(i8* %5, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0)), !dbg !200
  call void @llvm.dbg.value(metadata %struct._IO_FILE* %6, metadata !174, metadata !DIExpression()), !dbg !195
  %7 = icmp eq %struct._IO_FILE* %6, null, !dbg !201
  br i1 %7, label %8, label %10, !dbg !203

8:                                                ; preds = %2
  %9 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @str.13, i64 0, i64 0)), !dbg !204
  tail call void @exit(i32 0) #8, !dbg !206
  unreachable, !dbg !206

10:                                               ; preds = %2
  %11 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0)), !dbg !207
  %12 = load i8*, i8** %4, align 8, !dbg !209, !tbaa !198
  %13 = tail call i32 @puts(i8* nonnull dereferenceable(1) %12), !dbg !210
  %14 = tail call i32 (%struct._IO_FILE*, i8*, ...) @fscanf(%struct._IO_FILE* nonnull %6, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.5, i64 0, i64 0), i32* nonnull @row, i32* nonnull @col, i32* nonnull @nnz), !dbg !211
  %15 = load i32, i32* @row, align 4, !dbg !212, !tbaa !127
  %16 = load i32, i32* @col, align 4, !dbg !213, !tbaa !127
  %17 = load i32, i32* @nnz, align 4, !dbg !214, !tbaa !127
  %18 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([68 x i8], [68 x i8]* @.str.6, i64 0, i64 0), i32 %15, i32 %16, i32 %17), !dbg !215
  %19 = load i32, i32* @nnz, align 4, !dbg !216, !tbaa !127
  %20 = icmp sgt i32 %19, 10000000, !dbg !218
  %21 = load i32, i32* @row, align 4, !dbg !219
  %22 = icmp sgt i32 %21, 5000000, !dbg !220
  %23 = or i1 %20, %22, !dbg !221
  %24 = load i32, i32* @col, align 4, !dbg !222
  %25 = icmp sgt i32 %24, 5000000, !dbg !223
  %26 = or i1 %23, %25, !dbg !221
  br i1 %26, label %29, label %27, !dbg !221

27:                                               ; preds = %10
  call void @llvm.dbg.value(metadata i32 0, metadata !178, metadata !DIExpression()), !dbg !224
  %28 = icmp sgt i32 %19, 0, !dbg !225
  br i1 %28, label %53, label %31, !dbg !227

29:                                               ; preds = %10
  %30 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([48 x i8], [48 x i8]* @str.12, i64 0, i64 0)), !dbg !228
  tail call void @exit(i32 0) #8, !dbg !230
  unreachable, !dbg !230

31:                                               ; preds = %53, %27
  %32 = tail call i32 @fclose(%struct._IO_FILE* nonnull %6), !dbg !231
  call void @llvm.dbg.value(metadata i32 1, metadata !180, metadata !DIExpression()), !dbg !232
  %33 = load i32, i32* @col, align 4, !dbg !233, !tbaa !127
  %34 = icmp slt i32 %33, 1, !dbg !235
  br i1 %34, label %63, label %35, !dbg !236

35:                                               ; preds = %31
  %36 = zext i32 %33 to i64, !dbg !236
  %37 = icmp eq i32 %33, 1, !dbg !236
  br i1 %37, label %38, label %40, !dbg !236

38:                                               ; preds = %51, %35
  %39 = phi i64 [ 1, %35 ], [ %42, %51 ]
  br label %66, !dbg !236

40:                                               ; preds = %35
  %41 = and i64 %36, 4294967294, !dbg !236
  %42 = or i64 %36, 1, !dbg !236
  br label %43, !dbg !236

43:                                               ; preds = %43, %40
  %44 = phi i64 [ 0, %40 ], [ %49, %43 ]
  %45 = or i64 %44, 1
  %46 = add i64 %45, 1
  %47 = getelementptr inbounds double, double* inttoptr (i64 3221225472 to double*), i64 %45, !dbg !237
  %48 = getelementptr inbounds double, double* inttoptr (i64 3221225472 to double*), i64 %46, !dbg !237
  store double 1.000000e+00, double* %47, align 8, !dbg !239, !tbaa !146
  store double 1.000000e+00, double* %48, align 16, !dbg !239, !tbaa !146
  %49 = add i64 %44, 2
  %50 = icmp eq i64 %49, %41
  br i1 %50, label %51, label %43, !llvm.loop !240

51:                                               ; preds = %43
  %52 = icmp eq i64 %41, %36, !dbg !236
  br i1 %52, label %63, label %38, !dbg !236

53:                                               ; preds = %27, %53
  %54 = phi i64 [ %59, %53 ], [ 0, %27 ]
  call void @llvm.dbg.value(metadata i64 %54, metadata !178, metadata !DIExpression()), !dbg !224
  %55 = getelementptr inbounds [10000000 x %struct.COO], [10000000 x %struct.COO]* @mat, i64 0, i64 %54, i32 0, !dbg !243
  %56 = getelementptr inbounds [10000000 x %struct.COO], [10000000 x %struct.COO]* @mat, i64 0, i64 %54, i32 1, !dbg !245
  %57 = getelementptr inbounds [10000000 x %struct.COO], [10000000 x %struct.COO]* @mat, i64 0, i64 %54, i32 2, !dbg !246
  %58 = tail call i32 (%struct._IO_FILE*, i8*, ...) @fscanf(%struct._IO_FILE* nonnull %6, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.8, i64 0, i64 0), i32* nonnull %55, i32* nonnull %56, double* nonnull %57), !dbg !247
  %59 = add nuw nsw i64 %54, 1, !dbg !248
  call void @llvm.dbg.value(metadata i64 %59, metadata !178, metadata !DIExpression()), !dbg !224
  %60 = load i32, i32* @nnz, align 4, !dbg !249, !tbaa !127
  %61 = sext i32 %60 to i64, !dbg !225
  %62 = icmp slt i64 %59, %61, !dbg !225
  br i1 %62, label %53, label %31, !dbg !227, !llvm.loop !250

63:                                               ; preds = %66, %51, %31
  call void @llvm.dbg.value(metadata i32 0, metadata !182, metadata !DIExpression()), !dbg !252
  %64 = load i32, i32* @nnz, align 4, !dbg !253, !tbaa !127
  %65 = icmp sgt i32 %64, 0, !dbg !254
  br i1 %65, label %76, label %71, !dbg !255

66:                                               ; preds = %38, %66
  %67 = phi i64 [ %69, %66 ], [ %39, %38 ]
  call void @llvm.dbg.value(metadata i64 %67, metadata !180, metadata !DIExpression()), !dbg !232
  %68 = getelementptr inbounds double, double* inttoptr (i64 3221225472 to double*), i64 %67, !dbg !237
  store double 1.000000e+00, double* %68, align 8, !dbg !239, !tbaa !146
  %69 = add nuw nsw i64 %67, 1, !dbg !256
  call void @llvm.dbg.value(metadata i64 %69, metadata !180, metadata !DIExpression()), !dbg !232
  %70 = icmp ult i64 %67, %36, !dbg !235
  br i1 %70, label %66, label %63, !dbg !236, !llvm.loop !257

71:                                               ; preds = %76, %63
  call void @llvm.dbg.value(metadata i32 1, metadata !187, metadata !DIExpression()), !dbg !258
  %72 = load i32, i32* @row, align 4, !dbg !259, !tbaa !127
  %73 = icmp slt i32 %72, 1, !dbg !261
  br i1 %73, label %96, label %74, !dbg !262

74:                                               ; preds = %71
  %75 = load i32, i32* inttoptr (i64 2415919104 to i32*), align 268435456, !dbg !263, !tbaa !127
  br label %104, !dbg !262

76:                                               ; preds = %63, %76
  %77 = phi i64 [ %92, %76 ], [ 0, %63 ]
  call void @llvm.dbg.value(metadata i64 %77, metadata !182, metadata !DIExpression()), !dbg !252
  %78 = getelementptr inbounds [10000000 x %struct.COO], [10000000 x %struct.COO]* @mat, i64 0, i64 %77, i32 2, !dbg !265
  %79 = bitcast double* %78 to i64*, !dbg !265
  %80 = load i64, i64* %79, align 8, !dbg !265, !tbaa !266
  %81 = getelementptr inbounds double, double* inttoptr (i64 2684354560 to double*), i64 %77, !dbg !268
  %82 = bitcast double* %81 to i64*, !dbg !269
  store i64 %80, i64* %82, align 8, !dbg !269, !tbaa !146
  %83 = getelementptr inbounds [10000000 x %struct.COO], [10000000 x %struct.COO]* @mat, i64 0, i64 %77, i32 1, !dbg !270
  %84 = load i32, i32* %83, align 4, !dbg !270, !tbaa !271
  %85 = getelementptr inbounds i32, i32* inttoptr (i64 2147483648 to i32*), i64 %77, !dbg !272
  store i32 %84, i32* %85, align 4, !dbg !273, !tbaa !127
  %86 = getelementptr inbounds [10000000 x %struct.COO], [10000000 x %struct.COO]* @mat, i64 0, i64 %77, i32 0, !dbg !274
  %87 = load i32, i32* %86, align 8, !dbg !274, !tbaa !275
  call void @llvm.dbg.value(metadata i32 %87, metadata !184, metadata !DIExpression()), !dbg !276
  %88 = sext i32 %87 to i64, !dbg !277
  %89 = getelementptr inbounds i32, i32* inttoptr (i64 2415919104 to i32*), i64 %88, !dbg !277
  %90 = load i32, i32* %89, align 4, !dbg !278, !tbaa !127
  %91 = add nsw i32 %90, 1, !dbg !278
  store i32 %91, i32* %89, align 4, !dbg !278, !tbaa !127
  %92 = add nuw nsw i64 %77, 1, !dbg !279
  call void @llvm.dbg.value(metadata i64 %92, metadata !182, metadata !DIExpression()), !dbg !252
  %93 = load i32, i32* @nnz, align 4, !dbg !253, !tbaa !127
  %94 = sext i32 %93 to i64, !dbg !254
  %95 = icmp slt i64 %92, %94, !dbg !254
  br i1 %95, label %76, label %71, !dbg !255, !llvm.loop !280

96:                                               ; preds = %104, %71
  tail call void @m5_checkpoint(i64 0, i64 0), !dbg !282
  call void @llvm.dbg.value(metadata i32 0, metadata !189, metadata !DIExpression()), !dbg !283
  br label %97, !dbg !284

97:                                               ; preds = %97, %96
  %98 = phi i64 [ 0, %96 ], [ %102, %97 ], !dbg !285
  %99 = or i64 %98, 1, !dbg !285
  %100 = getelementptr inbounds [65536 x double], [65536 x double]* @cache_flush, i64 0, i64 %98, !dbg !287
  %101 = getelementptr inbounds [65536 x double], [65536 x double]* @cache_flush, i64 0, i64 %99, !dbg !287
  store double 1.000000e+00, double* %100, align 8, !dbg !289, !tbaa !146
  store double 1.000000e+00, double* %101, align 8, !dbg !289, !tbaa !146
  %102 = add i64 %98, 2, !dbg !285
  %103 = icmp eq i64 %102, 65536, !dbg !285
  br i1 %103, label %114, label %97, !dbg !285, !llvm.loop !290

104:                                              ; preds = %74, %104
  %105 = phi i32 [ %75, %74 ], [ %109, %104 ], !dbg !263
  %106 = phi i64 [ 1, %74 ], [ %110, %104 ]
  call void @llvm.dbg.value(metadata i64 %106, metadata !187, metadata !DIExpression()), !dbg !258
  %107 = getelementptr inbounds i32, i32* inttoptr (i64 2415919104 to i32*), i64 %106, !dbg !292
  %108 = load i32, i32* %107, align 4, !dbg !293, !tbaa !127
  %109 = add nsw i32 %108, %105, !dbg !293
  store i32 %109, i32* %107, align 4, !dbg !293, !tbaa !127
  %110 = add nuw nsw i64 %106, 1, !dbg !294
  call void @llvm.dbg.value(metadata i64 %110, metadata !187, metadata !DIExpression()), !dbg !258
  %111 = load i32, i32* @row, align 4, !dbg !259, !tbaa !127
  %112 = sext i32 %111 to i64, !dbg !261
  %113 = icmp slt i64 %106, %112, !dbg !261
  br i1 %113, label %104, label %96, !dbg !262, !llvm.loop !295

114:                                              ; preds = %97
  %115 = getelementptr inbounds i8*, i8** %1, i64 1, !dbg !297
  %116 = load i8*, i8** %115, align 8, !dbg !297, !tbaa !198
  %117 = tail call i32 @strcmp(i8* nonnull dereferenceable(1) %116, i8* nonnull dereferenceable(5) getelementptr inbounds ([5 x i8], [5 x i8]* @.str.9, i64 0, i64 0)) #9, !dbg !298
  %118 = icmp eq i32 %117, 0, !dbg !299
  br i1 %118, label %119, label %154, !dbg !300

119:                                              ; preds = %114
  %120 = tail call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([24 x i8], [24 x i8]* @str.11, i64 0, i64 0)), !dbg !301
  call void @llvm.dbg.value(metadata i32 0, metadata !191, metadata !DIExpression()), !dbg !302
  %121 = load i32, i32* @row, align 4, !dbg !303, !tbaa !127
  %122 = icmp sgt i32 %121, 0, !dbg !303
  %123 = zext i32 %121 to i64, !dbg !307
  br i1 %122, label %124, label %154, !dbg !308

124:                                              ; preds = %119
  call void @llvm.dbg.value(metadata i32 0, metadata !191, metadata !DIExpression()), !dbg !302
  call void @llvm.dbg.value(metadata double* inttoptr (i64 2952790016 to double*), metadata !111, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata double* inttoptr (i64 3221225472 to double*), metadata !112, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata double* inttoptr (i64 2684354560 to double*), metadata !113, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i32* inttoptr (i64 2415919104 to i32*), metadata !114, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i32* inttoptr (i64 2147483648 to i32*), metadata !115, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i32 0, metadata !118, metadata !DIExpression()), !dbg !307
  %125 = load i32, i32* inttoptr (i64 2415919104 to i32*), align 268435456, !dbg !310, !tbaa !127
  br label %126, !dbg !311

126:                                              ; preds = %152, %124
  %127 = phi i32 [ %125, %124 ], [ %131, %152 ], !dbg !310
  %128 = phi i64 [ 0, %124 ], [ %129, %152 ]
  call void @llvm.dbg.value(metadata i64 %128, metadata !118, metadata !DIExpression()), !dbg !307
  call void @llvm.dbg.value(metadata i32 %127, metadata !116, metadata !DIExpression()), !dbg !309
  %129 = add nuw nsw i64 %128, 1, !dbg !312
  %130 = getelementptr inbounds i32, i32* inttoptr (i64 2415919104 to i32*), i64 %129, !dbg !313
  %131 = load i32, i32* %130, align 4, !dbg !313, !tbaa !127
  call void @llvm.dbg.value(metadata i32 %131, metadata !117, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i32 %127, metadata !120, metadata !DIExpression()), !dbg !314
  %132 = icmp slt i32 %127, %131, !dbg !315
  br i1 %132, label %133, label %152, !dbg !316, !llvm.loop !317

133:                                              ; preds = %126
  %134 = getelementptr inbounds double, double* inttoptr (i64 2952790016 to double*), i64 %128, !dbg !319
  %135 = sext i32 %127 to i64, !dbg !316
  %136 = sext i32 %131 to i64, !dbg !315
  %137 = load double, double* %134, align 8, !dbg !320, !tbaa !146
  br label %138, !dbg !316

138:                                              ; preds = %138, %133
  %139 = phi double [ %137, %133 ], [ %149, %138 ], !dbg !320
  %140 = phi i64 [ %135, %133 ], [ %150, %138 ]
  call void @llvm.dbg.value(metadata i64 %140, metadata !120, metadata !DIExpression()), !dbg !314
  %141 = getelementptr inbounds double, double* inttoptr (i64 2684354560 to double*), i64 %140, !dbg !321
  %142 = load double, double* %141, align 8, !dbg !321, !tbaa !146
  %143 = getelementptr inbounds i32, i32* inttoptr (i64 2147483648 to i32*), i64 %140, !dbg !322
  %144 = load i32, i32* %143, align 4, !dbg !322, !tbaa !127
  %145 = sext i32 %144 to i64, !dbg !323
  %146 = getelementptr inbounds double, double* inttoptr (i64 3221225472 to double*), i64 %145, !dbg !323
  %147 = load double, double* %146, align 8, !dbg !323, !tbaa !146
  %148 = fmul double %142, %147, !dbg !324
  %149 = fadd double %139, %148, !dbg !320
  store double %149, double* %134, align 8, !dbg !320, !tbaa !146
  %150 = add nsw i64 %140, 1, !dbg !325
  call void @llvm.dbg.value(metadata i64 %150, metadata !120, metadata !DIExpression()), !dbg !314
  %151 = icmp eq i64 %150, %136, !dbg !315
  br i1 %151, label %152, label %138, !dbg !316, !llvm.loop !326

152:                                              ; preds = %138, %126
  call void @llvm.dbg.value(metadata i64 %129, metadata !118, metadata !DIExpression()), !dbg !307
  %153 = icmp eq i64 %129, %123, !dbg !328
  br i1 %153, label %189, label %126, !dbg !311

154:                                              ; preds = %215, %119, %114
  tail call void @m5_reset_stats(i64 0, i64 0), !dbg !329
  call void @llvm.dbg.value(metadata double* inttoptr (i64 2952790016 to double*), metadata !111, metadata !DIExpression()), !dbg !330
  call void @llvm.dbg.value(metadata double* inttoptr (i64 3221225472 to double*), metadata !112, metadata !DIExpression()), !dbg !330
  call void @llvm.dbg.value(metadata double* inttoptr (i64 2684354560 to double*), metadata !113, metadata !DIExpression()), !dbg !330
  call void @llvm.dbg.value(metadata i32* inttoptr (i64 2415919104 to i32*), metadata !114, metadata !DIExpression()), !dbg !330
  call void @llvm.dbg.value(metadata i32* inttoptr (i64 2147483648 to i32*), metadata !115, metadata !DIExpression()), !dbg !330
  call void @llvm.dbg.value(metadata i32 0, metadata !118, metadata !DIExpression()), !dbg !332
  %155 = load i32, i32* @row, align 4, !dbg !333, !tbaa !127
  %156 = icmp sgt i32 %155, 0, !dbg !334
  br i1 %156, label %157, label %188, !dbg !335

157:                                              ; preds = %154
  %158 = zext i32 %155 to i64, !dbg !335
  %159 = load i32, i32* inttoptr (i64 2415919104 to i32*), align 268435456, !dbg !336, !tbaa !127
  br label %162, !dbg !335

160:                                              ; preds = %174, %162
  call void @llvm.dbg.value(metadata i64 %165, metadata !118, metadata !DIExpression()), !dbg !332
  %161 = icmp eq i64 %165, %158, !dbg !334
  br i1 %161, label %188, label %162, !dbg !335

162:                                              ; preds = %160, %157
  %163 = phi i32 [ %159, %157 ], [ %167, %160 ], !dbg !336
  %164 = phi i64 [ 0, %157 ], [ %165, %160 ]
  call void @llvm.dbg.value(metadata i64 %164, metadata !118, metadata !DIExpression()), !dbg !332
  call void @llvm.dbg.value(metadata i32 %163, metadata !116, metadata !DIExpression()), !dbg !330
  %165 = add nuw nsw i64 %164, 1, !dbg !337
  %166 = getelementptr inbounds i32, i32* inttoptr (i64 2415919104 to i32*), i64 %165, !dbg !338
  %167 = load i32, i32* %166, align 4, !dbg !338, !tbaa !127
  call void @llvm.dbg.value(metadata i32 %167, metadata !117, metadata !DIExpression()), !dbg !330
  call void @llvm.dbg.value(metadata i32 %163, metadata !120, metadata !DIExpression()), !dbg !339
  %168 = icmp slt i32 %163, %167, !dbg !340
  br i1 %168, label %169, label %160, !dbg !341, !llvm.loop !342

169:                                              ; preds = %162
  %170 = getelementptr inbounds double, double* inttoptr (i64 2952790016 to double*), i64 %164, !dbg !344
  %171 = sext i32 %163 to i64, !dbg !341
  %172 = sext i32 %167 to i64, !dbg !340
  %173 = load double, double* %170, align 8, !dbg !345, !tbaa !146
  br label %174, !dbg !341

174:                                              ; preds = %174, %169
  %175 = phi double [ %173, %169 ], [ %185, %174 ], !dbg !345
  %176 = phi i64 [ %171, %169 ], [ %186, %174 ]
  call void @llvm.dbg.value(metadata i64 %176, metadata !120, metadata !DIExpression()), !dbg !339
  %177 = getelementptr inbounds double, double* inttoptr (i64 2684354560 to double*), i64 %176, !dbg !346
  %178 = load double, double* %177, align 8, !dbg !346, !tbaa !146
  %179 = getelementptr inbounds i32, i32* inttoptr (i64 2147483648 to i32*), i64 %176, !dbg !347
  %180 = load i32, i32* %179, align 4, !dbg !347, !tbaa !127
  %181 = sext i32 %180 to i64, !dbg !348
  %182 = getelementptr inbounds double, double* inttoptr (i64 3221225472 to double*), i64 %181, !dbg !348
  %183 = load double, double* %182, align 8, !dbg !348, !tbaa !146
  %184 = fmul double %178, %183, !dbg !349
  %185 = fadd double %175, %184, !dbg !345
  store double %185, double* %170, align 8, !dbg !345, !tbaa !146
  %186 = add nsw i64 %176, 1, !dbg !350
  call void @llvm.dbg.value(metadata i64 %186, metadata !120, metadata !DIExpression()), !dbg !339
  %187 = icmp eq i64 %186, %172, !dbg !340
  br i1 %187, label %160, label %174, !dbg !341, !llvm.loop !351

188:                                              ; preds = %160, %154
  tail call void @m5_dump_stats(i64 0, i64 0), !dbg !353
  ret i32 0, !dbg !354

189:                                              ; preds = %152, %215
  %190 = phi i32 [ %194, %215 ], [ %125, %152 ], !dbg !310
  %191 = phi i64 [ %192, %215 ], [ 0, %152 ]
  call void @llvm.dbg.value(metadata i64 %191, metadata !118, metadata !DIExpression()), !dbg !307
  call void @llvm.dbg.value(metadata i32 %190, metadata !116, metadata !DIExpression()), !dbg !309
  %192 = add nuw nsw i64 %191, 1, !dbg !312
  %193 = getelementptr inbounds i32, i32* inttoptr (i64 2415919104 to i32*), i64 %192, !dbg !313
  %194 = load i32, i32* %193, align 4, !dbg !313, !tbaa !127
  call void @llvm.dbg.value(metadata i32 %194, metadata !117, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i32 %190, metadata !120, metadata !DIExpression()), !dbg !314
  %195 = icmp slt i32 %190, %194, !dbg !315
  br i1 %195, label %196, label %215, !dbg !316, !llvm.loop !317

196:                                              ; preds = %189
  %197 = getelementptr inbounds double, double* inttoptr (i64 2952790016 to double*), i64 %191, !dbg !319
  %198 = sext i32 %190 to i64, !dbg !316
  %199 = sext i32 %194 to i64, !dbg !315
  %200 = load double, double* %197, align 8, !dbg !320, !tbaa !146
  br label %201, !dbg !316

201:                                              ; preds = %201, %196
  %202 = phi double [ %200, %196 ], [ %212, %201 ], !dbg !320
  %203 = phi i64 [ %198, %196 ], [ %213, %201 ]
  call void @llvm.dbg.value(metadata i64 %203, metadata !120, metadata !DIExpression()), !dbg !314
  %204 = getelementptr inbounds double, double* inttoptr (i64 2684354560 to double*), i64 %203, !dbg !321
  %205 = load double, double* %204, align 8, !dbg !321, !tbaa !146
  %206 = getelementptr inbounds i32, i32* inttoptr (i64 2147483648 to i32*), i64 %203, !dbg !322
  %207 = load i32, i32* %206, align 4, !dbg !322, !tbaa !127
  %208 = sext i32 %207 to i64, !dbg !323
  %209 = getelementptr inbounds double, double* inttoptr (i64 3221225472 to double*), i64 %208, !dbg !323
  %210 = load double, double* %209, align 8, !dbg !323, !tbaa !146
  %211 = fmul double %205, %210, !dbg !324
  %212 = fadd double %202, %211, !dbg !320
  store double %212, double* %197, align 8, !dbg !320, !tbaa !146
  %213 = add nsw i64 %203, 1, !dbg !325
  call void @llvm.dbg.value(metadata i64 %213, metadata !120, metadata !DIExpression()), !dbg !314
  %214 = icmp eq i64 %213, %199, !dbg !315
  br i1 %214, label %215, label %201, !dbg !316, !llvm.loop !326

215:                                              ; preds = %201, %189
  call void @llvm.dbg.value(metadata i64 %192, metadata !118, metadata !DIExpression()), !dbg !307
  %216 = icmp eq i64 %192, %123, !dbg !328
  br i1 %216, label %154, label %189, !dbg !311
}

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare dso_local noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #2

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare dso_local i32 @fscanf(%struct._IO_FILE* nocapture, i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare !dbg !10 dso_local i32 @fclose(%struct._IO_FILE* nocapture) local_unnamed_addr #2

declare !dbg !69 dso_local void @m5_checkpoint(i64, i64) local_unnamed_addr #4

; Function Attrs: nofree nounwind readonly
declare dso_local i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #5

declare !dbg !73 dso_local void @m5_reset_stats(i64, i64) local_unnamed_addr #4

declare !dbg !74 dso_local void @m5_dump_stats(i64, i64) local_unnamed_addr #4

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #6

; Function Attrs: nofree nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #7

attributes #0 = { nofree norecurse nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { norecurse "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nofree nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="-neon,-sve" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readnone speculatable willreturn }
attributes #7 = { nofree nounwind }
attributes #8 = { noreturn nounwind }
attributes #9 = { nounwind readonly }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!103, !104, !105}
!llvm.ident = !{!106}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "cache_flush", scope: !2, file: !3, line: 15, type: !100, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !3, producer: "Ubuntu clang version 10.0.1-++20211003084855+ef32c611aa21-1~exp1~20211003085243.2", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !75, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "src/spmv_csr.cpp", directory: "/home/fugelin/Work/Research/gem5/prefetch_project/sam_swpf/program/spmv")
!4 = !{}
!5 = !{!6, !8, !10, !69, !73, !74}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!10 = !DISubprogram(name: "fclose", scope: !11, file: !11, line: 199, type: !12, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !4)
!11 = !DIFile(filename: "/usr/aarch64-linux-gnu/include/stdio.h", directory: "")
!12 = !DISubroutineType(types: !13)
!13 = !{!7, !14}
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !16, line: 245, size: 1728, flags: DIFlagTypePassByValue, elements: !17, identifier: "_ZTS8_IO_FILE")
!16 = !DIFile(filename: "/usr/aarch64-linux-gnu/include/bits/libio.h", directory: "")
!17 = !{!18, !19, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !35, !36, !37, !38, !42, !44, !46, !50, !53, !55, !57, !58, !59, !60, !64, !65}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !15, file: !16, line: 246, baseType: !7, size: 32)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !15, file: !16, line: 251, baseType: !20, size: 64, offset: 64)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_unsigned_char)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !15, file: !16, line: 252, baseType: !20, size: 64, offset: 128)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !15, file: !16, line: 253, baseType: !20, size: 64, offset: 192)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !15, file: !16, line: 254, baseType: !20, size: 64, offset: 256)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !15, file: !16, line: 255, baseType: !20, size: 64, offset: 320)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !15, file: !16, line: 256, baseType: !20, size: 64, offset: 384)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !15, file: !16, line: 257, baseType: !20, size: 64, offset: 448)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !15, file: !16, line: 258, baseType: !20, size: 64, offset: 512)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !15, file: !16, line: 260, baseType: !20, size: 64, offset: 576)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !15, file: !16, line: 261, baseType: !20, size: 64, offset: 640)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !15, file: !16, line: 262, baseType: !20, size: 64, offset: 704)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !15, file: !16, line: 264, baseType: !33, size: 64, offset: 768)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !16, line: 160, flags: DIFlagFwdDecl, identifier: "_ZTS10_IO_marker")
!35 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !15, file: !16, line: 266, baseType: !14, size: 64, offset: 832)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !15, file: !16, line: 268, baseType: !7, size: 32, offset: 896)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !15, file: !16, line: 272, baseType: !7, size: 32, offset: 928)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !15, file: !16, line: 274, baseType: !39, size: 64, offset: 960)
!39 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !40, line: 140, baseType: !41)
!40 = !DIFile(filename: "/usr/aarch64-linux-gnu/include/bits/types.h", directory: "")
!41 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !15, file: !16, line: 278, baseType: !43, size: 16, offset: 1024)
!43 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !15, file: !16, line: 279, baseType: !45, size: 8, offset: 1040)
!45 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !15, file: !16, line: 280, baseType: !47, size: 8, offset: 1048)
!47 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 8, elements: !48)
!48 = !{!49}
!49 = !DISubrange(count: 1)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !15, file: !16, line: 284, baseType: !51, size: 64, offset: 1088)
!51 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !52, size: 64)
!52 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !16, line: 154, baseType: null)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !15, file: !16, line: 293, baseType: !54, size: 64, offset: 1152)
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !40, line: 141, baseType: !41)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !15, file: !16, line: 301, baseType: !56, size: 64, offset: 1216)
!56 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !15, file: !16, line: 302, baseType: !56, size: 64, offset: 1280)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "__pad3", scope: !15, file: !16, line: 303, baseType: !56, size: 64, offset: 1344)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "__pad4", scope: !15, file: !16, line: 304, baseType: !56, size: 64, offset: 1408)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "__pad5", scope: !15, file: !16, line: 306, baseType: !61, size: 64, offset: 1472)
!61 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !62, line: 46, baseType: !63)
!62 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.1/include/stddef.h", directory: "")
!63 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !15, file: !16, line: 307, baseType: !7, size: 32, offset: 1536)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !15, file: !16, line: 309, baseType: !66, size: 160, offset: 1568)
!66 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 160, elements: !67)
!67 = !{!68}
!68 = !DISubrange(count: 20)
!69 = !DISubprogram(name: "m5_checkpoint", scope: !70, file: !70, line: 54, type: !71, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !4)
!70 = !DIFile(filename: "src/../../../../gem5_bfs/include/gem5/m5ops.h", directory: "/home/fugelin/Work/Research/gem5/prefetch_project/sam_swpf/program/spmv")
!71 = !DISubroutineType(types: !72)
!72 = !{null, !63, !63}
!73 = !DISubprogram(name: "m5_reset_stats", scope: !70, file: !70, line: 55, type: !71, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !4)
!74 = !DISubprogram(name: "m5_dump_stats", scope: !70, file: !70, line: 56, type: !71, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !4)
!75 = !{!0, !76, !78, !80, !82, !93, !96, !98}
!76 = !DIGlobalVariableExpression(var: !77, expr: !DIExpression())
!77 = distinct !DIGlobalVariable(name: "row", scope: !2, file: !3, line: 21, type: !7, isLocal: false, isDefinition: true)
!78 = !DIGlobalVariableExpression(var: !79, expr: !DIExpression())
!79 = distinct !DIGlobalVariable(name: "col", scope: !2, file: !3, line: 21, type: !7, isLocal: false, isDefinition: true)
!80 = !DIGlobalVariableExpression(var: !81, expr: !DIExpression())
!81 = distinct !DIGlobalVariable(name: "nnz", scope: !2, file: !3, line: 21, type: !7, isLocal: false, isDefinition: true)
!82 = !DIGlobalVariableExpression(var: !83, expr: !DIExpression())
!83 = distinct !DIGlobalVariable(name: "mat", scope: !2, file: !3, line: 51, type: !84, isLocal: false, isDefinition: true)
!84 = !DICompositeType(tag: DW_TAG_array_type, baseType: !85, size: 1280000000, elements: !91)
!85 = !DIDerivedType(tag: DW_TAG_typedef, name: "COO", file: !3, line: 49, baseType: !86)
!86 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 45, size: 128, flags: DIFlagTypePassByValue, elements: !87, identifier: "_ZTS3COO")
!87 = !{!88, !89, !90}
!88 = !DIDerivedType(tag: DW_TAG_member, name: "r", scope: !86, file: !3, line: 46, baseType: !7, size: 32)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !86, file: !3, line: 47, baseType: !7, size: 32, offset: 32)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "val", scope: !86, file: !3, line: 48, baseType: !9, size: 64, offset: 64)
!91 = !{!92}
!92 = !DISubrange(count: 10000000)
!93 = !DIGlobalVariableExpression(var: !94, expr: !DIExpression(DW_OP_constu, 10000000, DW_OP_stack_value))
!94 = distinct !DIGlobalVariable(name: "max_nnz", scope: !2, file: !3, line: 11, type: !95, isLocal: true, isDefinition: true)
!95 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !7)
!96 = !DIGlobalVariableExpression(var: !97, expr: !DIExpression(DW_OP_constu, 5000000, DW_OP_stack_value))
!97 = distinct !DIGlobalVariable(name: "max_row", scope: !2, file: !3, line: 9, type: !95, isLocal: true, isDefinition: true)
!98 = !DIGlobalVariableExpression(var: !99, expr: !DIExpression(DW_OP_constu, 5000000, DW_OP_stack_value))
!99 = distinct !DIGlobalVariable(name: "max_col", scope: !2, file: !3, line: 10, type: !95, isLocal: true, isDefinition: true)
!100 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 4194304, elements: !101)
!101 = !{!102}
!102 = !DISubrange(count: 65536)
!103 = !{i32 7, !"Dwarf Version", i32 4}
!104 = !{i32 2, !"Debug Info Version", i32 3}
!105 = !{i32 1, !"wchar_size", i32 4}
!106 = !{!"Ubuntu clang version 10.0.1-++20211003084855+ef32c611aa21-1~exp1~20211003085243.2"}
!107 = distinct !DISubprogram(name: "mul", linkageName: "_Z3mulPdS_S_PiS0_", scope: !3, file: !3, line: 53, type: !108, scopeLine: 54, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !110)
!108 = !DISubroutineType(types: !109)
!109 = !{null, !8, !8, !8, !6, !6}
!110 = !{!111, !112, !113, !114, !115, !116, !117, !118, !120}
!111 = !DILocalVariable(name: "ret", arg: 1, scope: !107, file: !3, line: 53, type: !8)
!112 = !DILocalVariable(name: "vec", arg: 2, scope: !107, file: !3, line: 53, type: !8)
!113 = !DILocalVariable(name: "val", arg: 3, scope: !107, file: !3, line: 53, type: !8)
!114 = !DILocalVariable(name: "row_ptr", arg: 4, scope: !107, file: !3, line: 53, type: !6)
!115 = !DILocalVariable(name: "col_idx", arg: 5, scope: !107, file: !3, line: 53, type: !6)
!116 = !DILocalVariable(name: "last_row", scope: !107, file: !3, line: 55, type: !7)
!117 = !DILocalVariable(name: "this_row", scope: !107, file: !3, line: 55, type: !7)
!118 = !DILocalVariable(name: "i", scope: !119, file: !3, line: 57, type: !7)
!119 = distinct !DILexicalBlock(scope: !107, file: !3, line: 57, column: 9)
!120 = !DILocalVariable(name: "j", scope: !121, file: !3, line: 60, type: !7)
!121 = distinct !DILexicalBlock(scope: !122, file: !3, line: 60, column: 13)
!122 = distinct !DILexicalBlock(scope: !123, file: !3, line: 57, column: 39)
!123 = distinct !DILexicalBlock(scope: !119, file: !3, line: 57, column: 9)
!124 = !DILocation(line: 0, scope: !107)
!125 = !DILocation(line: 0, scope: !119)
!126 = !DILocation(line: 57, column: 29, scope: !123)
!127 = !{!128, !128, i64 0}
!128 = !{!"int", !129, i64 0}
!129 = !{!"omnipotent char", !130, i64 0}
!130 = !{!"Simple C++ TBAA"}
!131 = !DILocation(line: 57, column: 27, scope: !123)
!132 = !DILocation(line: 57, column: 9, scope: !119)
!133 = !DILocation(line: 58, column: 24, scope: !122)
!134 = !DILocation(line: 65, column: 1, scope: !107)
!135 = !DILocation(line: 59, column: 33, scope: !122)
!136 = !DILocation(line: 59, column: 24, scope: !122)
!137 = !DILocation(line: 0, scope: !121)
!138 = !DILocation(line: 60, column: 38, scope: !139)
!139 = distinct !DILexicalBlock(scope: !121, file: !3, line: 60, column: 13)
!140 = !DILocation(line: 60, column: 13, scope: !121)
!141 = distinct !{!141, !132, !142}
!142 = !DILocation(line: 64, column: 9, scope: !119)
!143 = !DILocation(line: 0, scope: !144)
!144 = distinct !DILexicalBlock(scope: !139, file: !3, line: 60, column: 55)
!145 = !DILocation(line: 61, column: 24, scope: !144)
!146 = !{!147, !147, i64 0}
!147 = !{!"double", !129, i64 0}
!148 = !DILocation(line: 61, column: 27, scope: !144)
!149 = !DILocation(line: 61, column: 40, scope: !144)
!150 = !DILocation(line: 61, column: 36, scope: !144)
!151 = !DILocation(line: 61, column: 34, scope: !144)
!152 = !DILocation(line: 60, column: 51, scope: !139)
!153 = distinct !{!153, !140, !154}
!154 = !DILocation(line: 63, column: 13, scope: !121)
!155 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 67, type: !156, scopeLine: 68, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !159)
!156 = !DISubroutineType(types: !157)
!157 = !{!7, !7, !158}
!158 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!159 = !{!160, !161, !162, !163, !164, !165, !166, !167, !169, !170, !172, !173, !174, !178, !180, !182, !184, !187, !189, !191}
!160 = !DILocalVariable(name: "argc", arg: 1, scope: !155, file: !3, line: 67, type: !7)
!161 = !DILocalVariable(name: "argv", arg: 2, scope: !155, file: !3, line: 67, type: !158)
!162 = !DILocalVariable(name: "col_addr", scope: !155, file: !3, line: 70, type: !6)
!163 = !DILocalVariable(name: "row_addr", scope: !155, file: !3, line: 70, type: !6)
!164 = !DILocalVariable(name: "val_addr", scope: !155, file: !3, line: 71, type: !8)
!165 = !DILocalVariable(name: "vec_addr", scope: !155, file: !3, line: 71, type: !8)
!166 = !DILocalVariable(name: "ret_addr", scope: !155, file: !3, line: 71, type: !8)
!167 = !DILocalVariable(name: "col_idx", scope: !155, file: !3, line: 125, type: !168)
!168 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6)
!169 = !DILocalVariable(name: "row_ptr", scope: !155, file: !3, line: 126, type: !168)
!170 = !DILocalVariable(name: "val", scope: !155, file: !3, line: 128, type: !171)
!171 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !8)
!172 = !DILocalVariable(name: "ret", scope: !155, file: !3, line: 129, type: !171)
!173 = !DILocalVariable(name: "vec", scope: !155, file: !3, line: 130, type: !171)
!174 = !DILocalVariable(name: "fp", scope: !155, file: !3, line: 146, type: !175)
!175 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !176, size: 64)
!176 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !177, line: 7, baseType: !15)
!177 = !DIFile(filename: "/usr/aarch64-linux-gnu/include/bits/types/FILE.h", directory: "")
!178 = !DILocalVariable(name: "i", scope: !179, file: !3, line: 163, type: !7)
!179 = distinct !DILexicalBlock(scope: !155, file: !3, line: 163, column: 5)
!180 = !DILocalVariable(name: "i", scope: !181, file: !3, line: 186, type: !7)
!181 = distinct !DILexicalBlock(scope: !155, file: !3, line: 186, column: 5)
!182 = !DILocalVariable(name: "i", scope: !183, file: !3, line: 191, type: !7)
!183 = distinct !DILexicalBlock(scope: !155, file: !3, line: 191, column: 5)
!184 = !DILocalVariable(name: "row_num", scope: !185, file: !3, line: 192, type: !7)
!185 = distinct !DILexicalBlock(scope: !186, file: !3, line: 191, column: 32)
!186 = distinct !DILexicalBlock(scope: !183, file: !3, line: 191, column: 5)
!187 = !DILocalVariable(name: "i", scope: !188, file: !3, line: 199, type: !7)
!188 = distinct !DILexicalBlock(scope: !155, file: !3, line: 199, column: 5)
!189 = !DILocalVariable(name: "i", scope: !190, file: !3, line: 229, type: !7)
!190 = distinct !DILexicalBlock(scope: !155, file: !3, line: 229, column: 5)
!191 = !DILocalVariable(name: "i", scope: !192, file: !3, line: 236, type: !7)
!192 = distinct !DILexicalBlock(scope: !193, file: !3, line: 236, column: 9)
!193 = distinct !DILexicalBlock(scope: !194, file: !3, line: 234, column: 35)
!194 = distinct !DILexicalBlock(scope: !155, file: !3, line: 234, column: 9)
!195 = !DILocation(line: 0, scope: !155)
!196 = !DILocation(line: 73, column: 5, scope: !155)
!197 = !DILocation(line: 146, column: 22, scope: !155)
!198 = !{!199, !199, i64 0}
!199 = !{!"any pointer", !129, i64 0}
!200 = !DILocation(line: 146, column: 16, scope: !155)
!201 = !DILocation(line: 148, column: 11, scope: !202)
!202 = distinct !DILexicalBlock(scope: !155, file: !3, line: 148, column: 8)
!203 = !DILocation(line: 148, column: 8, scope: !155)
!204 = !DILocation(line: 149, column: 9, scope: !205)
!205 = distinct !DILexicalBlock(scope: !202, file: !3, line: 148, column: 19)
!206 = !DILocation(line: 150, column: 9, scope: !205)
!207 = !DILocation(line: 152, column: 9, scope: !208)
!208 = distinct !DILexicalBlock(scope: !202, file: !3, line: 151, column: 10)
!209 = !DILocation(line: 153, column: 23, scope: !208)
!210 = !DILocation(line: 153, column: 9, scope: !208)
!211 = !DILocation(line: 156, column: 5, scope: !155)
!212 = !DILocation(line: 157, column: 83, scope: !155)
!213 = !DILocation(line: 157, column: 87, scope: !155)
!214 = !DILocation(line: 157, column: 91, scope: !155)
!215 = !DILocation(line: 157, column: 5, scope: !155)
!216 = !DILocation(line: 158, column: 9, scope: !217)
!217 = distinct !DILexicalBlock(scope: !155, file: !3, line: 158, column: 8)
!218 = !DILocation(line: 158, column: 13, scope: !217)
!219 = !DILocation(line: 158, column: 26, scope: !217)
!220 = !DILocation(line: 158, column: 30, scope: !217)
!221 = !DILocation(line: 158, column: 23, scope: !217)
!222 = !DILocation(line: 158, column: 43, scope: !217)
!223 = !DILocation(line: 158, column: 47, scope: !217)
!224 = !DILocation(line: 0, scope: !179)
!225 = !DILocation(line: 163, column: 23, scope: !226)
!226 = distinct !DILexicalBlock(scope: !179, file: !3, line: 163, column: 5)
!227 = !DILocation(line: 163, column: 5, scope: !179)
!228 = !DILocation(line: 160, column: 9, scope: !229)
!229 = distinct !DILexicalBlock(scope: !217, file: !3, line: 159, column: 5)
!230 = !DILocation(line: 161, column: 9, scope: !229)
!231 = !DILocation(line: 169, column: 5, scope: !155)
!232 = !DILocation(line: 0, scope: !181)
!233 = !DILocation(line: 186, column: 19, scope: !234)
!234 = distinct !DILexicalBlock(scope: !181, file: !3, line: 186, column: 5)
!235 = !DILocation(line: 186, column: 18, scope: !234)
!236 = !DILocation(line: 186, column: 5, scope: !181)
!237 = !DILocation(line: 188, column: 9, scope: !238)
!238 = distinct !DILexicalBlock(scope: !234, file: !3, line: 187, column: 5)
!239 = !DILocation(line: 188, column: 16, scope: !238)
!240 = distinct !{!240, !236, !241, !242}
!241 = !DILocation(line: 189, column: 5, scope: !181)
!242 = !{!"llvm.loop.isvectorized", i32 1}
!243 = !DILocation(line: 164, column: 38, scope: !244)
!244 = distinct !DILexicalBlock(scope: !226, file: !3, line: 163, column: 34)
!245 = !DILocation(line: 164, column: 48, scope: !244)
!246 = !DILocation(line: 164, column: 59, scope: !244)
!247 = !DILocation(line: 164, column: 9, scope: !244)
!248 = !DILocation(line: 163, column: 31, scope: !226)
!249 = !DILocation(line: 163, column: 25, scope: !226)
!250 = distinct !{!250, !227, !251}
!251 = !DILocation(line: 168, column: 5, scope: !179)
!252 = !DILocation(line: 0, scope: !183)
!253 = !DILocation(line: 191, column: 23, scope: !186)
!254 = !DILocation(line: 191, column: 21, scope: !186)
!255 = !DILocation(line: 191, column: 5, scope: !183)
!256 = !DILocation(line: 186, column: 26, scope: !234)
!257 = distinct !{!257, !236, !241, !242}
!258 = !DILocation(line: 0, scope: !188)
!259 = !DILocation(line: 199, column: 23, scope: !260)
!260 = distinct !DILexicalBlock(scope: !188, file: !3, line: 199, column: 5)
!261 = !DILocation(line: 199, column: 21, scope: !260)
!262 = !DILocation(line: 199, column: 5, scope: !188)
!263 = !DILocation(line: 200, column: 22, scope: !264)
!264 = distinct !DILexicalBlock(scope: !260, file: !3, line: 199, column: 35)
!265 = !DILocation(line: 193, column: 25, scope: !185)
!266 = !{!267, !147, i64 8}
!267 = !{!"_ZTS3COO", !128, i64 0, !128, i64 4, !147, i64 8}
!268 = !DILocation(line: 193, column: 9, scope: !185)
!269 = !DILocation(line: 193, column: 16, scope: !185)
!270 = !DILocation(line: 194, column: 29, scope: !185)
!271 = !{!267, !128, i64 4}
!272 = !DILocation(line: 194, column: 9, scope: !185)
!273 = !DILocation(line: 194, column: 20, scope: !185)
!274 = !DILocation(line: 195, column: 26, scope: !185)
!275 = !{!267, !128, i64 0}
!276 = !DILocation(line: 0, scope: !185)
!277 = !DILocation(line: 196, column: 9, scope: !185)
!278 = !DILocation(line: 196, column: 26, scope: !185)
!279 = !DILocation(line: 191, column: 28, scope: !186)
!280 = distinct !{!280, !255, !281}
!281 = !DILocation(line: 197, column: 5, scope: !183)
!282 = !DILocation(line: 226, column: 5, scope: !155)
!283 = !DILocation(line: 0, scope: !190)
!284 = !DILocation(line: 229, column: 5, scope: !190)
!285 = !DILocation(line: 229, column: 31, scope: !286)
!286 = distinct !DILexicalBlock(scope: !190, file: !3, line: 229, column: 5)
!287 = !DILocation(line: 230, column: 9, scope: !288)
!288 = distinct !DILexicalBlock(scope: !286, file: !3, line: 229, column: 34)
!289 = !DILocation(line: 230, column: 24, scope: !288)
!290 = distinct !{!290, !284, !291, !242}
!291 = !DILocation(line: 231, column: 5, scope: !190)
!292 = !DILocation(line: 200, column: 9, scope: !264)
!293 = !DILocation(line: 200, column: 20, scope: !264)
!294 = !DILocation(line: 199, column: 31, scope: !260)
!295 = distinct !{!295, !262, !296}
!296 = !DILocation(line: 201, column: 5, scope: !188)
!297 = !DILocation(line: 234, column: 16, scope: !194)
!298 = !DILocation(line: 234, column: 9, scope: !194)
!299 = !DILocation(line: 234, column: 31, scope: !194)
!300 = !DILocation(line: 234, column: 9, scope: !155)
!301 = !DILocation(line: 235, column: 9, scope: !193)
!302 = !DILocation(line: 0, scope: !192)
!303 = !DILocation(line: 0, scope: !123, inlinedAt: !304)
!304 = distinct !DILocation(line: 237, column: 13, scope: !305)
!305 = distinct !DILexicalBlock(scope: !306, file: !3, line: 236, column: 30)
!306 = distinct !DILexicalBlock(scope: !192, file: !3, line: 236, column: 9)
!307 = !DILocation(line: 0, scope: !119, inlinedAt: !304)
!308 = !DILocation(line: 236, column: 9, scope: !192)
!309 = !DILocation(line: 0, scope: !107, inlinedAt: !304)
!310 = !DILocation(line: 58, column: 24, scope: !122, inlinedAt: !304)
!311 = !DILocation(line: 57, column: 9, scope: !119, inlinedAt: !304)
!312 = !DILocation(line: 59, column: 33, scope: !122, inlinedAt: !304)
!313 = !DILocation(line: 59, column: 24, scope: !122, inlinedAt: !304)
!314 = !DILocation(line: 0, scope: !121, inlinedAt: !304)
!315 = !DILocation(line: 60, column: 38, scope: !139, inlinedAt: !304)
!316 = !DILocation(line: 60, column: 13, scope: !121, inlinedAt: !304)
!317 = distinct !{!317, !311, !318}
!318 = !DILocation(line: 64, column: 9, scope: !119, inlinedAt: !304)
!319 = !DILocation(line: 0, scope: !144, inlinedAt: !304)
!320 = !DILocation(line: 61, column: 24, scope: !144, inlinedAt: !304)
!321 = !DILocation(line: 61, column: 27, scope: !144, inlinedAt: !304)
!322 = !DILocation(line: 61, column: 40, scope: !144, inlinedAt: !304)
!323 = !DILocation(line: 61, column: 36, scope: !144, inlinedAt: !304)
!324 = !DILocation(line: 61, column: 34, scope: !144, inlinedAt: !304)
!325 = !DILocation(line: 60, column: 51, scope: !139, inlinedAt: !304)
!326 = distinct !{!326, !316, !327}
!327 = !DILocation(line: 63, column: 13, scope: !121, inlinedAt: !304)
!328 = !DILocation(line: 57, column: 27, scope: !123, inlinedAt: !304)
!329 = !DILocation(line: 241, column: 5, scope: !155)
!330 = !DILocation(line: 0, scope: !107, inlinedAt: !331)
!331 = distinct !DILocation(line: 242, column: 5, scope: !155)
!332 = !DILocation(line: 0, scope: !119, inlinedAt: !331)
!333 = !DILocation(line: 57, column: 29, scope: !123, inlinedAt: !331)
!334 = !DILocation(line: 57, column: 27, scope: !123, inlinedAt: !331)
!335 = !DILocation(line: 57, column: 9, scope: !119, inlinedAt: !331)
!336 = !DILocation(line: 58, column: 24, scope: !122, inlinedAt: !331)
!337 = !DILocation(line: 59, column: 33, scope: !122, inlinedAt: !331)
!338 = !DILocation(line: 59, column: 24, scope: !122, inlinedAt: !331)
!339 = !DILocation(line: 0, scope: !121, inlinedAt: !331)
!340 = !DILocation(line: 60, column: 38, scope: !139, inlinedAt: !331)
!341 = !DILocation(line: 60, column: 13, scope: !121, inlinedAt: !331)
!342 = distinct !{!342, !335, !343}
!343 = !DILocation(line: 64, column: 9, scope: !119, inlinedAt: !331)
!344 = !DILocation(line: 0, scope: !144, inlinedAt: !331)
!345 = !DILocation(line: 61, column: 24, scope: !144, inlinedAt: !331)
!346 = !DILocation(line: 61, column: 27, scope: !144, inlinedAt: !331)
!347 = !DILocation(line: 61, column: 40, scope: !144, inlinedAt: !331)
!348 = !DILocation(line: 61, column: 36, scope: !144, inlinedAt: !331)
!349 = !DILocation(line: 61, column: 34, scope: !144, inlinedAt: !331)
!350 = !DILocation(line: 60, column: 51, scope: !139, inlinedAt: !331)
!351 = distinct !{!351, !341, !352}
!352 = !DILocation(line: 63, column: 13, scope: !121, inlinedAt: !331)
!353 = !DILocation(line: 243, column: 5, scope: !155)
!354 = !DILocation(line: 269, column: 5, scope: !155)
