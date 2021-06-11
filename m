Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D92C3A4A12
	for <lists+linux-sctp@lfdr.de>; Fri, 11 Jun 2021 22:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFKUXD (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 11 Jun 2021 16:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhFKUXB (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 11 Jun 2021 16:23:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D35C061574
        for <linux-sctp@vger.kernel.org>; Fri, 11 Jun 2021 13:20:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l9so8709636wms.1
        for <linux-sctp@vger.kernel.org>; Fri, 11 Jun 2021 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LttOf1bYSjJrAZlhpwocbmwcvvZpkGD+oDptV4MgPoA=;
        b=YZQ+TSzI5oCWxHQslM1Fk8b92cThG+Bilf+Rayojd6dqXuIfGVDBXf0lIfQXywLQjE
         9qC0Szn9YmEI4+wHosqKdQGHMvuH7Ehhn7QwnjpvRXY4xpbmI5JFO2eN6rUyD+rmlfmd
         VYvhLr21JzYKMeqF0A+QuOKc6voeH9/wNdhgZbmvaGjkFVrL1cFC6Io6CC1IsbtOzuqM
         tytk8Z90ECiYdJtM506U7hU8efTBcWa5QyjPNvWLRcRyRgmZCjJVQatzmoqMglnbXdJm
         cb3ZeCBlJ8nJijVzcD84YuwtC4aTubOtFMXXexKWZGEQx/ICusgbZfpNJBDbsWMFMdfv
         Lycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LttOf1bYSjJrAZlhpwocbmwcvvZpkGD+oDptV4MgPoA=;
        b=BjTGu39fn37a0O5UcVNe9cjS/yOQjQVtC0iew7KpgRLBMNdPx0P/QqDWf7rL9ccl38
         BaLE6Gu7O3Pw1O4oBa4Kw/zhBY8Kg/CUFjDCNEiv0u3L+ZcmeCnxB4OPAUpNgKjzg7uX
         N2RExEC22/PWs22eIf7L4dmpDpw+TsNPiQ2YxOnzj3jN/EIKUk3qebiVINSCq+qAnEsi
         rPJbUVrbo0dBXyPDC5hx3KJ6suu9ZdyCDe/VONIXUMJ8757J6Pn6nPXc6JO0eEfjBfIh
         IrlwnXJDim+VOU9gQ8cCT4nc94f6RV+4bnD9X04lUVRikKS4sLT/6EQaw1cldwtUl/po
         J8xg==
X-Gm-Message-State: AOAM531BQ/tbdUWOdrqCqM94JP57cp8anJYwTssn2HZyYThBw3SYR1BA
        kXCseiEzOsuyd/GAYvMWI5HbUqGUAyPX6YCn+fCA0QFNtzK+Dw==
X-Google-Smtp-Source: ABdhPJxhFY1PdIkdN+gqe/IgF37dOqbD8OM2KH4TVSbKxLuZyTSI8MmmG7E+6+zptOgy/i1q+Krw1Y44qyHzxSjr3MQ=
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr5472132wmm.156.1623442848427;
 Fri, 11 Jun 2021 13:20:48 -0700 (PDT)
MIME-Version: 1.0
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 11 Jun 2021 16:20:38 -0400
Message-ID: <CADvbK_c0dmke8Ei2sLiVqZ2ExgcmZyuPwpHBgW9g6Cjdi+rzug@mail.gmail.com>
Subject: The new sysctl and socket option added for PLPMTUD (RFC8899)
To:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Michael Tuexen <tuexen@freebsd.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi, Michael,

In the linux implementation of RFC8899, we decided to introduce one
sysctl and one socket option for users to set up the PLPMUTD probe:

1. sysctl -w net.sctp.plpmtud_probe_interval=1

plpmtud_probe_interval - INTEGER
        The interval (in milliseconds) between PLPMTUD probe chunks. These
        chunks are sent at the specified interval with a variable size to
        probe the mtu of a given path between 2 associations. PLPMTUD will
        be disabled when 0 is set.

        Default: 0

2. a socket option that can be used per socket, assoc or transport

/* PLPMTUD Probe Interval socket option */
struct sctp_probeinterval {
        sctp_assoc_t spi_assoc_id;
        struct sockaddr_storage spi_address;
        __u32 spi_interval;
};

#define SCTP_PLPMTUD_PROBE_INTERVAL    133


The value above will enable/disable the PLPMUTD probe by setting up the probe
interval for the timer. When it's 0, the timer will also stop and
PLPMUTD is disabled.
By this way, we don't need to introduce more options.

We're expecting to keep consistent with BSD on this, pls check and
share your thoughts.

Thanks.
