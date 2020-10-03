Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520152825C7
	for <lists+linux-sctp@lfdr.de>; Sat,  3 Oct 2020 20:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgJCSHi (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 3 Oct 2020 14:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgJCSHh (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 3 Oct 2020 14:07:37 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB3C0613D0
        for <linux-sctp@vger.kernel.org>; Sat,  3 Oct 2020 11:07:36 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d1so5719328qtr.6
        for <linux-sctp@vger.kernel.org>; Sat, 03 Oct 2020 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ATR9wD0a/FdwUda6TKJWv+F4vP760VB0pB7pmoqEA1E=;
        b=cubNasvZKSbzI5BE0UnX1Lj5FLW7N0l50maOM/kdaVhGT0xG3q/F6yjvsj5dNRoHF4
         TRwWMAfIxjuo+SQHp7/l3vWjqk6YYLNZ8xn4AGWSRkTjhAOM34k1lN1sOMRy7fxilYFK
         2Mu0h93gEofWcszG6SmV+4DQyheqsqC1CsDI5HFIeqNzFPHKwkB92qA0YaYQMRYz81iH
         JRFOgiOW49DRwSI7tfkAnxB7Kr9gQ1hB2q2k+gz5XpXnvCAShewV15FyNPtBv/CVmV4b
         89KNl0M22yvux6/4UlPdDyA7kMohdMVLYj2DJYHgE/7t4IhDEG4xjiKe8vTmnBTZGOtB
         NS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ATR9wD0a/FdwUda6TKJWv+F4vP760VB0pB7pmoqEA1E=;
        b=lK1MVMl62AxDE/cCU1WqJoB8hezJ+9pwaf2KwCZ+PU6RVu8vHXQBZwx3xEIjH6zQGz
         vwaY/vumIwNHieurNK8VpR2d6qGFbdc1BE1ArIXulZHxFobYXWaPCL0Po5396TP8FbZH
         XHndcE0Z25qaKS1JZaBXWa46yZlx0D4wXs3xAZO34VRy+8KAVGtpxnLUnS5unTqV2hz0
         tZcbc5+VW9ZsXTtojK6YramnTNQXIgzkiwE6L9WEotMz+OHJOUdYsAhJ7LfAqAJ/qqVO
         e2FA0ASN8mm0mosbqaJ1ZuoJtqNMUO6+QCtd6ybNq0l8pMpC3kA0CJZxaQeSgakcNaP5
         xmuw==
X-Gm-Message-State: AOAM533YISo3gT76jXUcEjPUZwcV2AxqEQ40Tjndlg4E7tzepSO04AEk
        vFOs/IO/aT8p5PXOVrEFkVU=
X-Google-Smtp-Source: ABdhPJwxJledoqf+XUgRSQ740xzfpfU8t1oSfXhXdJxy5M8pe54zEpjz5V7cXq64mik6ybfi7sPuKw==
X-Received: by 2002:ac8:2c78:: with SMTP id e53mr7630798qta.298.1601748455368;
        Sat, 03 Oct 2020 11:07:35 -0700 (PDT)
Received: from localhost.localdomain ([177.220.172.62])
        by smtp.gmail.com with ESMTPSA id b43sm3909854qtk.84.2020.10.03.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 11:07:34 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id B76FEC6195; Sat,  3 Oct 2020 15:07:31 -0300 (-03)
Date:   Sat, 3 Oct 2020 15:07:31 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     linux-sctp@vger.kernel.org
Subject: Re: [PATCH lksctp-tools] Use symvmer attribute, not asms for symbol
 versioning
Message-ID: <20201003180731.GJ70998@localhost.localdomain>
References: <20200918184830.469979-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918184830.469979-1-plautrba@redhat.com>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Sep 18, 2020 at 08:48:30PM +0200, Petr Lautrbach wrote:
> This project could not be built with LTO as it uses ASMs to implement
> symbol versioning. ASMs like this are fundamentally incompatible with
> LTO because GCC does not look inside the ASM string to find symbol
> references. Starting with gcc-10 there is a new symbol attribute for
> implementing symbol versioning.
> 
> A fallback to the old way of implementing symbol versioning via asms is
> included, so it should work with clang as well as gcc-9 and
> earlier.
> 
> Fixes: https://github.com/sctp/lksctp-tools/issues/35
> 
> Author: Jeff Law <law@redhat.com>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Applied, thanks.
