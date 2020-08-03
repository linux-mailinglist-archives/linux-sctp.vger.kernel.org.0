Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB44423A2B3
	for <lists+linux-sctp@lfdr.de>; Mon,  3 Aug 2020 12:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHCKXs (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 3 Aug 2020 06:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCKXs (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 3 Aug 2020 06:23:48 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6A1C06174A
        for <linux-sctp@vger.kernel.org>; Mon,  3 Aug 2020 03:23:47 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id q3so403672ybp.7
        for <linux-sctp@vger.kernel.org>; Mon, 03 Aug 2020 03:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yyIEu7MWMuebmzKl4V/44bcFi0Yhfnd5vIckyZ+HhC0=;
        b=qQ7Ix5MYxSRaPdbg6zQqj9eMtis8ZpGkzIBFhmQu7MuyIK6HArUGVxZ6NuK/8kb3PD
         YgRUycWASatrURZRSr2pIR8O/f8s9jV19yKF0TLKqZ7QC367p27q7KPeaa6kjx4CWgjA
         ZgLmAQ6BmSTGdYMfEGCsNhG8IrtNqoROv92gWKmxj5eIv2utwxPKZlrzVCz1l1S14zof
         wCDVGQXWWZhZb7C15E0IncB/nEREIbFkGcA1uTalQwG/g8xkVPBdqKuVmXfhH9xwcGKS
         eg3cNzp5hXBH1qmdx7AYxuco75HpeMlbA4QDHTgu3OfQ1FE+zejBb73QPeTZ+LToR/fU
         yQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yyIEu7MWMuebmzKl4V/44bcFi0Yhfnd5vIckyZ+HhC0=;
        b=EJA2c5z8gaMi2mKQRAgq1iSRrHGBnURj9TwuboC90i6Dc84CZUN9ZBdwW9jEMXIXTd
         hbkhHK1w+0JyAg1HZyDsQCSJb5Eec7VYp3Krj2y6VV/CaGzI1e/MZmELzGxjRM3A9PDy
         X0lj7X67KtI6CQaN59Z6DjHIp55hu9MLf/lmRDZgg7s3TA6sxXoRU65qwzFUEIjx35iv
         LZiokWZVg+0sZHkdwDorIifCJL16TGHpxThc/o9PISljVt5GZKIBUlxY0cpnht1/RCf7
         N72dEhSrF12poKnMULMG8DRi105RevXgQRPLl1V6cPEU07JyJcSqgmFqT7g5YJivqX3p
         rCYQ==
X-Gm-Message-State: AOAM530huVLJGyuXyaDQ4pNJ89nAcuwPgrjFmzYeVvMExWZGWgGZMT3k
        aSCzybWrdeS0NeXPOgKqt0P3YDBgEQVpHv6s7IaSilHu
X-Google-Smtp-Source: ABdhPJx2hWVYfHM5WQC19/PpJmkCQzMtFHuE/KQIs1NQn+teQdfHlrGXBkHR1ivWucKXo5FuB9NOiPJ7VJZDWdVmqGo=
X-Received: by 2002:a25:e482:: with SMTP id b124mr23571914ybh.506.1596450226864;
 Mon, 03 Aug 2020 03:23:46 -0700 (PDT)
MIME-Version: 1.0
From:   sonia bhattacharya <soniaruby1@gmail.com>
Date:   Mon, 3 Aug 2020 15:53:35 +0530
Message-ID: <CAMyZL9pE+343HvMHuci=+2aKS4HrtuL2GJ2oVwxw7PfL7=doKQ@mail.gmail.com>
Subject: Regarding kernel SCTP module compliance to 4960
To:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Team,



Is there a plan to upgrade the linux SCTP kernel module to be
compliant to RFC 4960?

Right now, it is compliant to RFC 2960.


description:    Support for the SCTP protocol (RFC2960)


Thanks,

Sonia
