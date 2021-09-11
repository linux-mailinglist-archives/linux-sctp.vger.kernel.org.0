Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082FA407436
	for <lists+linux-sctp@lfdr.de>; Sat, 11 Sep 2021 02:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhIKAiD (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 10 Sep 2021 20:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhIKAiD (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 10 Sep 2021 20:38:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D903C061574
        for <linux-sctp@vger.kernel.org>; Fri, 10 Sep 2021 17:36:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n5so4956170wro.12
        for <linux-sctp@vger.kernel.org>; Fri, 10 Sep 2021 17:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Z8DD82Hu7AsVHVawAxFzqJ6DeQUxwXQGgFtNofKsm+ZuTU/BXo+CaG8LIPpaCgAjaG
         XgmDveEyyJMaLzjCdKyLK8MAKpSdafcdtv6fqkd01f5GgZWCAePYh5sxb1dCAM4QRp9j
         nYuTAR3cLSZxzd85G9Ijk1Aqqdd2HiVa1kUHCSdz8VRK+jmS9D20arci7lqPu9flQ38x
         BYL1g4MWszOgItYMg8a8K/zQNEB+1BzxR0YbCM38+ZHqlLIEvLdkwlq2gm4+VFV0GbQK
         egigorfHAsaEoVM7KPae0AICJjSrHvBc6UclC1AO3ZVj1HWZqGHNawQsIj3PCdXlWbbo
         m8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=r+G44jz7MuuobudBNnsPBIEZC3PStas3ZAyzP/xUjtkgkFTBhfGZrr7q6GunR1FyHM
         Ws76XJUkBtH+usEKzsD7husTwbR0RQlK4+eMPixW5UqHas7Dy/0njZfjbDfmQULpNy2W
         8qg5QIWfAKF9juJ0/iIB9+neDTwjCJuCsFeq+Dc2ZgdRG0DP0t5l3ZExDQWxS56+A6yB
         8+cxqH+b647CjJflcDlLd9IkQ68nbHKbAsYnUXDaDlwRgjunlXKSsrxRaZ3NagXwm2r1
         RCfGEE1R/x+y/F9bd+wtr0g17HfdT4HlMdRaXH84M4JF8u6Tj2RU1Kmd7udb0t+AAxEF
         +DgQ==
X-Gm-Message-State: AOAM533e6Ht0RFo4b3NjWoT5H/qlKdjmBWbVLs1XaU9XC9rtERO6oXdM
        fj9/oe9sNsD/8mKwBmedtfDqNLAhErWgHhfymws=
X-Google-Smtp-Source: ABdhPJz4og6+0r+5bvtFUH7juhmGUdG+UjUs2LK3fCJohm4DVJCYXCXjSL6LoYrq/wo/ctTzzpbC+RrGxlQ08IOUJhE=
X-Received: by 2002:adf:de09:: with SMTP id b9mr449163wrm.114.1631320609888;
 Fri, 10 Sep 2021 17:36:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9103:0:0:0:0:0 with HTTP; Fri, 10 Sep 2021 17:36:49
 -0700 (PDT)
Reply-To: kw751150@gmail.com
From:   "Mr. Darian Rich (Barrick Gold Corps)" <dariusgavi1@gmail.com>
Date:   Sat, 11 Sep 2021 01:36:49 +0100
Message-ID: <CAEh1i2frRBGvbaGYySTxN0a5xjGHR=+ewFQqW2L-tQoS-8PcZQ@mail.gmail.com>
Subject: =?UTF-8?Q?Gr=C3=BC=C3=9Fe=2C_ich_brauche_Ihre_Partnerschaft_bei_einem_Li?=
        =?UTF-8?Q?efervertrag_in_H=C3=B6he_von_40_Millionen_US=2DDollar_in_Ihrem_Lan?=
        =?UTF-8?Q?d=2E_Kontaktieren_Sie_mich_f=C3=BCr_Details=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org


