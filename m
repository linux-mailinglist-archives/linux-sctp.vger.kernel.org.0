Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D71769357
	for <lists+linux-sctp@lfdr.de>; Mon, 31 Jul 2023 12:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjGaKp6 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 31 Jul 2023 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGaKp5 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 31 Jul 2023 06:45:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E5BE48
        for <linux-sctp@vger.kernel.org>; Mon, 31 Jul 2023 03:45:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bbf3da0ea9so14221145ad.2
        for <linux-sctp@vger.kernel.org>; Mon, 31 Jul 2023 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690800355; x=1691405155;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v0zWuCqMHEa4Hik0KmuuyfsbGPnrEXMY8uIWR18mNY=;
        b=f1oLeK/8+pb8nuvjbvFa8sZ4RYvnHDDrPzDLbSWYy0EKp5TeTWqJpjVp+Z3k68WFuD
         1FX9pvY8uMPuAMJk+APbmxEp8pjN7/cJskBwsgv0W3Zb2mxX3NLGs8Rh2Aq7NVnHywlc
         jjacESxP/A0YLO0rUownb4cqhPkob5bV0gOMeZwUBQhB8L/XbGP6hHB9WKscobDlU4Qy
         ce9flQnk3HeC3hjsR8KerR3jzjXrO5l8KN0AN2MdbgstjhE0g/i4V9/BJpSAfYIOaon6
         2CVHHnkoOZqCs5GFewY4VLxcNQccIguOYBVe8Mk5a6kj2NQ2eKkojKbAtmedLdZ3lHlY
         4tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800355; x=1691405155;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2v0zWuCqMHEa4Hik0KmuuyfsbGPnrEXMY8uIWR18mNY=;
        b=fJFUaLqVriAlwJNo/0CAEtbQeXMcZJInV7aXfnYjYfgyhW9gcudsQlZglP2Mb6dAN7
         U5g0PxIErDsk2+h7iudxC/fN4PzDbpXEqXplhOVjNsDb5zHpd9E5/ABaHfRGhtNa+e5f
         WEGHGOVbrts+xgfENAs8QN0ZQXyZYDTYDHk0euROcHtRZuXTFpQT1UZ1x+OwmtLoZTyP
         6Q59+5GYGuGTAcbpTTsPxIhoT0x7oF67P12c+zmUk5ovrEaiTl2QTlWZoPcvmVpicoj+
         lR9lRh4Yy/yu6st0FFhEKPwW2ZFeVtKIFST4QW1XvocJ5L8kInjYwwHg4L+lcxIS4NGh
         a57A==
X-Gm-Message-State: ABy/qLZfK16e3C+XoXSPZ1bAR1fW2/N0Qvm6ubc2emJL5KcKZpm+CqnG
        lk8d1nGnZijskHsxwRbmsPpeLt3DtCEeR4ZsCo8=
X-Google-Smtp-Source: APBJJlGlmEBmM8a7nJFKj25jxP4dkAE4hvLWbX2G+V+Teh18m8SzhQdM25Mq1dfmh01IvX8j7t1yoExVBXTEWkv28kg=
X-Received: by 2002:a17:90a:de91:b0:263:68b0:8ca5 with SMTP id
 n17-20020a17090ade9100b0026368b08ca5mr7861808pjv.43.1690800355636; Mon, 31
 Jul 2023 03:45:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a21:3d87:b0:127:777e:3f0c with HTTP; Mon, 31 Jul 2023
 03:45:55 -0700 (PDT)
Reply-To: klantenservicce@gmail.com
From:   George Knowless <appllezr77@gmail.com>
Date:   Mon, 31 Jul 2023 11:45:55 +0100
Message-ID: <CA+FickhHx6+mawYEqEeC1r9+wVPRukhgO8PRp_5CEdPg=XrAdA@mail.gmail.com>
Subject: Kindly attend to this
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Greetings,

I'm requesting your cooperation in the transfer of an inheritance of
28.5M for a deceased client that shared the same last name as you.

I will explain this in detail, upon your readiness to work with me
toward actualizing this goal/objective.

Regards,

Mr. George Knowless
