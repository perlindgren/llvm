; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; REQUIRES: asserts
; RUN: opt -O2 -S < %s | FileCheck %s
; RUN: opt -passes='default<O2>' -S < %s | FileCheck %s --check-prefix=NPM

target datalayout = "e-m:e-i64:64-n32:64"
target triple = "powerpc64le-unknown-linux-gnu"

define dso_local i64 @func(i64 %blah, i64 %limit) #0 {
; CHECK-LABEL: @func(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP4:%.*]] = icmp eq i64 [[LIMIT:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP4]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY_LR_PH:%.*]]
; CHECK:       for.body.lr.ph:
; CHECK-NEXT:    [[CONV:%.*]] = and i64 [[BLAH:%.*]], 4294967295
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[LIMIT]], -1
; CHECK-NEXT:    [[XTRAITER:%.*]] = and i64 [[LIMIT]], 7
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i64 [[TMP0]], 7
; CHECK-NEXT:    br i1 [[TMP1]], label [[FOR_COND_CLEANUP_LOOPEXIT_UNR_LCSSA:%.*]], label [[FOR_BODY_LR_PH_NEW:%.*]]
; CHECK:       for.body.lr.ph.new:
; CHECK-NEXT:    [[UNROLL_ITER:%.*]] = sub i64 [[LIMIT]], [[XTRAITER]]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit.unr-lcssa:
; CHECK-NEXT:    [[ADD_LCSSA_PH:%.*]] = phi i64 [ undef, [[FOR_BODY_LR_PH]] ], [ [[ADD_7:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[K_05_UNR:%.*]] = phi i64 [ 1, [[FOR_BODY_LR_PH]] ], [ [[AND:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[LCMP_MOD:%.*]] = icmp eq i64 [[XTRAITER]], 0
; CHECK-NEXT:    br i1 [[LCMP_MOD]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY_EPIL:%.*]]
; CHECK:       for.body.epil:
; CHECK-NEXT:    [[G_06_EPIL:%.*]] = phi i64 [ [[ADD_EPIL:%.*]], [[FOR_BODY_EPIL]] ], [ [[ADD_LCSSA_PH]], [[FOR_COND_CLEANUP_LOOPEXIT_UNR_LCSSA]] ]
; CHECK-NEXT:    [[K_05_EPIL:%.*]] = phi i64 [ [[AND_EPIL:%.*]], [[FOR_BODY_EPIL]] ], [ [[K_05_UNR]], [[FOR_COND_CLEANUP_LOOPEXIT_UNR_LCSSA]] ]
; CHECK-NEXT:    [[EPIL_ITER:%.*]] = phi i64 [ [[EPIL_ITER_SUB:%.*]], [[FOR_BODY_EPIL]] ], [ [[XTRAITER]], [[FOR_COND_CLEANUP_LOOPEXIT_UNR_LCSSA]] ]
; CHECK-NEXT:    [[AND_EPIL]] = and i64 [[CONV]], [[K_05_EPIL]]
; CHECK-NEXT:    [[ADD_EPIL]] = add i64 [[AND_EPIL]], [[G_06_EPIL]]
; CHECK-NEXT:    [[EPIL_ITER_SUB]] = add i64 [[EPIL_ITER]], -1
; CHECK-NEXT:    [[EPIL_ITER_CMP:%.*]] = icmp eq i64 [[EPIL_ITER_SUB]], 0
; CHECK-NEXT:    br i1 [[EPIL_ITER_CMP]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY_EPIL]], !llvm.loop !0
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    [[G_0_LCSSA:%.*]] = phi i64 [ undef, [[ENTRY:%.*]] ], [ [[ADD_LCSSA_PH]], [[FOR_COND_CLEANUP_LOOPEXIT_UNR_LCSSA]] ], [ [[ADD_EPIL]], [[FOR_BODY_EPIL]] ]
; CHECK-NEXT:    ret i64 [[G_0_LCSSA]]
; CHECK:       for.body:
; CHECK-NEXT:    [[G_06:%.*]] = phi i64 [ undef, [[FOR_BODY_LR_PH_NEW]] ], [ [[ADD_7]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[K_05:%.*]] = phi i64 [ 1, [[FOR_BODY_LR_PH_NEW]] ], [ [[AND]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[NITER:%.*]] = phi i64 [ [[UNROLL_ITER]], [[FOR_BODY_LR_PH_NEW]] ], [ [[NITER_NSUB_7:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[AND]] = and i64 [[CONV]], [[K_05]]
; CHECK-NEXT:    [[ADD:%.*]] = add i64 [[AND]], [[G_06]]
; CHECK-NEXT:    [[ADD_1:%.*]] = add i64 [[AND]], [[ADD]]
; CHECK-NEXT:    [[ADD_2:%.*]] = add i64 [[AND]], [[ADD_1]]
; CHECK-NEXT:    [[ADD_3:%.*]] = add i64 [[AND]], [[ADD_2]]
; CHECK-NEXT:    [[ADD_4:%.*]] = add i64 [[AND]], [[ADD_3]]
; CHECK-NEXT:    [[ADD_5:%.*]] = add i64 [[AND]], [[ADD_4]]
; CHECK-NEXT:    [[ADD_6:%.*]] = add i64 [[AND]], [[ADD_5]]
; CHECK-NEXT:    [[ADD_7]] = add i64 [[AND]], [[ADD_6]]
; CHECK-NEXT:    [[NITER_NSUB_7]] = add i64 [[NITER]], -8
; CHECK-NEXT:    [[NITER_NCMP_7:%.*]] = icmp eq i64 [[NITER_NSUB_7]], 0
; CHECK-NEXT:    br i1 [[NITER_NCMP_7]], label [[FOR_COND_CLEANUP_LOOPEXIT_UNR_LCSSA]], label [[FOR_BODY]]
;
; NPM-LABEL: @func(
; NPM-NEXT:  entry:
; NPM-NEXT:    [[CMP4:%.*]] = icmp eq i64 [[LIMIT:%.*]], 0
; NPM-NEXT:    br i1 [[CMP4]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY_LR_PH:%.*]]
; NPM:       for.body.lr.ph:
; NPM-NEXT:    [[CONV:%.*]] = and i64 [[BLAH:%.*]], 4294967295
; NPM-NEXT:    [[TMP0:%.*]] = add i64 [[LIMIT]], -1
; NPM-NEXT:    [[XTRAITER:%.*]] = and i64 [[LIMIT]], 7
; NPM-NEXT:    [[TMP1:%.*]] = icmp ult i64 [[TMP0]], 7
; NPM-NEXT:    br i1 [[TMP1]], label [[FOR_COND_CLEANUP_LOOPEXIT_UNR_LCSSA:%.*]], label [[FOR_BODY_LR_PH_NEW:%.*]]
; NPM:       for.body.lr.ph.new:
; NPM-NEXT:    [[UNROLL_ITER:%.*]] = sub i64 [[LIMIT]], [[XTRAITER]]
; NPM-NEXT:    [[AND_0:%.*]] = and i64 [[CONV]], 1
; NPM-NEXT:    br label [[FOR_BODY:%.*]]
; NPM:       for.cond.cleanup.loopexit.unr-lcssa:
; NPM-NEXT:    [[ADD_LCSSA_PH:%.*]] = phi i64 [ undef, [[FOR_BODY_LR_PH]] ], [ [[ADD_7:%.*]], [[FOR_BODY]] ]
; NPM-NEXT:    [[K_05_UNR:%.*]] = phi i64 [ 1, [[FOR_BODY_LR_PH]] ], [ [[AND_PHI:%.*]], [[FOR_BODY]] ]
; NPM-NEXT:    [[LCMP_MOD:%.*]] = icmp eq i64 [[XTRAITER]], 0
; NPM-NEXT:    br i1 [[LCMP_MOD]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY_EPIL:%.*]]
; NPM:       for.body.epil:
; NPM-NEXT:    [[G_06_EPIL:%.*]] = phi i64 [ [[ADD_EPIL:%.*]], [[FOR_BODY_EPIL]] ], [ [[ADD_LCSSA_PH]], [[FOR_COND_CLEANUP_LOOPEXIT_UNR_LCSSA]] ]
; NPM-NEXT:    [[K_05_EPIL:%.*]] = phi i64 [ [[AND_EPIL:%.*]], [[FOR_BODY_EPIL]] ], [ [[K_05_UNR]], [[FOR_COND_CLEANUP_LOOPEXIT_UNR_LCSSA]] ]
; NPM-NEXT:    [[EPIL_ITER:%.*]] = phi i64 [ [[EPIL_ITER_SUB:%.*]], [[FOR_BODY_EPIL]] ], [ [[XTRAITER]], [[FOR_COND_CLEANUP_LOOPEXIT_UNR_LCSSA]] ]
; NPM-NEXT:    [[AND_EPIL]] = and i64 [[CONV]], [[K_05_EPIL]]
; NPM-NEXT:    [[ADD_EPIL]] = add i64 [[AND_EPIL]], [[G_06_EPIL]]
; NPM-NEXT:    [[EPIL_ITER_SUB]] = add i64 [[EPIL_ITER]], -1
; NPM-NEXT:    [[EPIL_ITER_CMP:%.*]] = icmp eq i64 [[EPIL_ITER_SUB]], 0
; NPM-NEXT:    br i1 [[EPIL_ITER_CMP]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY_EPIL]], !llvm.loop !0
; NPM:       for.cond.cleanup:
; NPM-NEXT:    [[G_0_LCSSA:%.*]] = phi i64 [ undef, [[ENTRY:%.*]] ], [ [[ADD_LCSSA_PH]], [[FOR_COND_CLEANUP_LOOPEXIT_UNR_LCSSA]] ], [ [[ADD_EPIL]], [[FOR_BODY_EPIL]] ]
; NPM-NEXT:    ret i64 [[G_0_LCSSA]]
; NPM:       for.body:
; NPM-NEXT:    [[G_06:%.*]] = phi i64 [ undef, [[FOR_BODY_LR_PH_NEW]] ], [ [[ADD_7]], [[FOR_BODY_FOR_BODY_CRIT_EDGE:%.*]] ]
; NPM-NEXT:    [[AND_PHI]] = phi i64 [ [[AND_0]], [[FOR_BODY_LR_PH_NEW]] ], [ [[AND_1:%.*]], [[FOR_BODY_FOR_BODY_CRIT_EDGE]] ]
; NPM-NEXT:    [[NITER:%.*]] = phi i64 [ [[UNROLL_ITER]], [[FOR_BODY_LR_PH_NEW]] ], [ [[NITER_NSUB_7:%.*]], [[FOR_BODY_FOR_BODY_CRIT_EDGE]] ]
; NPM-NEXT:    [[ADD:%.*]] = add i64 [[AND_PHI]], [[G_06]]
; NPM-NEXT:    [[ADD_1:%.*]] = add i64 [[AND_PHI]], [[ADD]]
; NPM-NEXT:    [[ADD_2:%.*]] = add i64 [[AND_PHI]], [[ADD_1]]
; NPM-NEXT:    [[ADD_3:%.*]] = add i64 [[AND_PHI]], [[ADD_2]]
; NPM-NEXT:    [[ADD_4:%.*]] = add i64 [[AND_PHI]], [[ADD_3]]
; NPM-NEXT:    [[ADD_5:%.*]] = add i64 [[AND_PHI]], [[ADD_4]]
; NPM-NEXT:    [[ADD_6:%.*]] = add i64 [[AND_PHI]], [[ADD_5]]
; NPM-NEXT:    [[ADD_7]] = add i64 [[AND_PHI]], [[ADD_6]]
; NPM-NEXT:    [[NITER_NSUB_7]] = add i64 [[NITER]], -8
; NPM-NEXT:    [[NITER_NCMP_7:%.*]] = icmp eq i64 [[NITER_NSUB_7]], 0
; NPM-NEXT:    br i1 [[NITER_NCMP_7]], label [[FOR_COND_CLEANUP_LOOPEXIT_UNR_LCSSA]], label [[FOR_BODY_FOR_BODY_CRIT_EDGE]]
; NPM:       for.body.for.body_crit_edge:
; NPM-NEXT:    [[AND_1]] = and i64 [[CONV]], [[AND_PHI]]
; NPM-NEXT:    br label [[FOR_BODY]]
;
entry:
  %blah.addr = alloca i64, align 8
  %limit.addr = alloca i64, align 8
  %k = alloca i32, align 4
  %g = alloca i64, align 8
  %i = alloca i64, align 8
  store i64 %blah, i64* %blah.addr, align 8
  store i64 %limit, i64* %limit.addr, align 8
  store i32 1, i32* %k, align 4
  store i64 0, i64* %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.body, %entry
  %0 = load i64, i64* %i, align 8
  %1 = load i64, i64* %limit.addr, align 8
  %cmp = icmp ult i64 %0, %1
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  %2 = load i64, i64* %g, align 8
  ret i64 %2

for.body:                                         ; preds = %for.cond
  %3 = load i64, i64* %blah.addr, align 8
  %4 = load i32, i32* %k, align 4
  %conv = zext i32 %4 to i64
  %and = and i64 %conv, %3
  %conv1 = trunc i64 %and to i32
  store i32 %conv1, i32* %k, align 4
  %5 = load i32, i32* %k, align 4
  %conv2 = zext i32 %5 to i64
  %6 = load i64, i64* %g, align 8
  %add = add i64 %6, %conv2
  store i64 %add, i64* %g, align 8
  %7 = load i64, i64* %i, align 8
  %inc = add i64 %7, 1
  store i64 %inc, i64* %i, align 8
  br label %for.cond
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

attributes #0 = { "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
